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

# This script replicates write-summary-dr-curve-script.pl, but directs
# gnuplot to generate fig output instead of png.

($tddr_dir, $responses_file, $gnuplot_script) = @ARGV;

open(RESPONSES, $responses_file) or
    die("write-gp-dr-curve-script.pl: could not open "
	. "responses file $responses_file.");
while(<RESPONSES>)
{
    chomp;
    ($dmp_file, $dmp_hdr) = split;
    $title = "$dmp_file--$dmp_hdr";
    push @titles, $title;

}
close(RESPONSES);

open(SCRIPT, ">$gnuplot_script") or
    die("write-gp-dr-curve-script.pl: could not open "
	. "output script $gnuplot_script.");

print SCRIPT "set terminal fig color\n";
print SCRIPT "set logscale x\n";
print SCRIPT "set xlabel \"Number of dose molecules\"\n";
print SCRIPT "set ylabel \"Mean number of response molecules\"\n";
print SCRIPT "plot \\\n";

@rest_titles = @titles;
while(@rest_titles)
{
    $title = shift @rest_titles;
    $histo_dir = "$tddr_dir/$title.histos";

    print SCRIPT
	"\"$histo_dir/all-drs\" using 1:2 with lines title \"$title\"";

    if(0 < @rest_titles)
    {
	print SCRIPT ", ";
    }
    else
    {
	print SCRIPT "\n";
    }
}
close(SCRIPT);
