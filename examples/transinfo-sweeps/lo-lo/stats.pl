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

($doses_file, $histos_dir) = @ARGV;

open(DOSES, $doses_file) or
    die("new-stats.pl: could not open doses file $doses_file");

# Omit the header line.
<DOSES>;

while(<DOSES>)
{
    ($dose_directory, $dose) = split;

    $dose_data_file = "$histos_dir/$dose.data";

    open(DATA, $dose_data_file) or
	die("new-stats.pl: could not open dose data file $dose_data_file");

    $total = 0.0;
    $totSq = 0.0;
    $count = 0;
    while($value = <DATA>)
    {
	chomp $value;

	$total += $value;
	$totSq += ($value * $value);
	$count++;
    }

    $mean = $total / $count;
    $second_moment = $totSq / $count;
    $sampleVariance
	= $count * ($second_moment - ($mean * $mean)) / ($count - 1);

    print "$dose\t$mean\t$sampleVariance\n";

    close(DATA);
}

close(DOSES);

