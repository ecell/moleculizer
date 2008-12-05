/////////////////////////////////////////////////////////////////////////////
// Moleculizer - a stochastic simulator for cellular chemistry.
// Copyright (C) 2001  Walter Lawrence (Larry) Lok.
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//    
// Contact information:
//   Larry Lok, Research Fellow          Voice: 510-981-8740
//   The Molecular Sciences Institute      Fax: 510-647-0699
//   2168 Shattuck Ave.                  Email: lok@molsci.org
//   Berkeley, CA 94704
/////////////////////////////////////////////////////////////////////////////

#include "utl/dom.hh"
#include "cpt/dumpStateEvent.hh"
#include "cpt/cptApp.hh"

namespace cpt
{
  dumpStateEvent::
  dumpStateEvent(const std::string& rOutputFileName) :
    outputFileName(rOutputFileName)
  {}
  
  fnd::eventResult
  dumpStateEvent::
  happen(cptApp& rCptApp)
    throw(std::exception)
  {
    xmlpp::Document* pOutputDoc = rCptApp.makeDomOutput();

    // I think that this may be the reason for std::exception;
    // e.g. if the file name is bad.  Quick check of xmlpp doc
    // says this isn't so, though.  I was probably treating xmlpp::exception
    // as std::exception, but even given that, this isn't documented as
    // throwing an exception.  Maybe they don't use throw clauses, or don't
    // give them in their documentation?
    pOutputDoc->write_to_file(outputFileName);

    delete pOutputDoc;

    return fnd::go;
  }
}