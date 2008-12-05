#!/usr/bin/perl
###############################################################################
# Moleculizer - a stochastic simulator for cellular chemistry.
# Copyright (C) 2001  Walter Lawrence (Larry) Lok.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#    
# Contact information:
#   Larry Lok, Research Fellow          Voice: 510-981-8740
#   The Molecular Sciences Institute      Fax: 510-647-0699
#   2168 Shattuck Ave.                  Email: lok@molsci.org
#   Berkeley, CA 94704
###############################################################################

use File::Copy;

# Parse the command line.
($input_file_path, $values_file_path, $root_dir, $output_file_name) = @ARGV;

print "do-substitutions.pl: input file is $input_file_path.\n";
print "do-substitutions.pl: values file is $values_file_path.\n";
print "do-substitutions.pl: root dir is $root_dir.\n";
print "do-substitutions.pl: output file name  is $output_file_name.\n";

# The first line of the tab_values_file gives the property values (like
# VAR1, VAR2, etc.) that are to be substituted with values on remaining lines
# of the tab_values_file.
open(VALUE_HANDLE, $values_file_path);
$_ = <VALUE_HANDLE>;
@sub_targets = split;

# The first item on the first line is the DIR header, which we don't
# need here.
shift @sub_targets;

# Just a part of doing multiple substitutions.
$substitution_source_path = "/tmp/"."$$"."_tddr_sub_source";
$substitution_target_path = "/tmp/"."$$"."_tddr_sub_target";

# Now read one line at a time from the tab_values_file to get values to
# substitute for the "symbolic" property values (like VAR1, VAR2, etc.)
# given on the first line of the file.
while(<VALUE_HANDLE>)
{
    @sub_values = split;

    # The first item is the directory, which we don't need here.
    $sub_dir= shift @sub_values;

    # To begin the loop, copy the input file to the substitution source.
    copy($input_file_path, $substitution_source_path) or
	die("do-substitutions.pl: could not copy input "
	    . "file path $input_file_path to substitution "
	    . "source path $substitution_source_path.");

    # Perform the substitutions one at a time.
    for($sub_ndx = 0;
	$sub_ndx < @sub_targets;
	$sub_ndx++)
    {
	print "do-substitutions.pl: substituting $sub_values[$sub_ndx] for $sub_targets[$sub_ndx].\n";

	# Do one substitution.
	system("java", "org.apache.xalan.xslt.Process",
	       "-in", "$substitution_source_path",
	       "-xsl", "$ENV{MOLECULIZER_DIR}/xml/xsl/edit-value.xsl",
	       "-param", "variable-marker", "$sub_targets[$sub_ndx]",
	       "-param", "new-value", "$sub_values[$sub_ndx]",
	       "-xml",
	       "-out", "$substitution_target_path");

	# Move the substitution_target_path to the substitution_source_path
	# for the next iteration.
	unlink $substitution_source_path;
	copy($substitution_target_path, $substitution_source_path) or
	    die("do-substitutions.pl: could not copy substitution target "
		. "path $substitution_target_path to substitution "
		. "source path $substitution_source_path.");

	unlink $substitution_target_path;
    }

    $output_file_path = "$root_dir/$sub_dir/$output_file_name";
    print "do-substitutions.pl: writing output at path $output_file_path.\n";
    copy($substitution_source_path, $output_file_path) or
	    die("do-substitutions.pl: could not copy substitution source "
		. "path $substitution_source_path to output "
		. "file path $output_file_path.");
    unlink $substitution_source_path;
}
