#
# StableCategories: Stable categories of additive categories
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "StableCategories",
Subtitle := "Stable categories of additive categories",
Version := "2020.09.05",
Date := ~.Version{[ 1 .. 10 ]},
Date := Concatenation( ~.Version{[ 9, 10 ]}, "/", ~.Version{[ 6, 7 ]}, "/", ~.Version{[ 1 .. 4 ]} ),
License := "GPL-2.0-or-later",

Persons := [
  rec(
    IsAuthor := true,
    IsMaintainer := true,
    FirstNames := "Kamal",
    LastName := "Saleh",
    WWWHome := "https://github.com/kamalsaleh",
    Email := "kamal.saleh@uni-siegen.de",
    PostalAddress := Concatenation(
                       "Department Mathematik\n",
                       "Universität Siegen\n",
                       "Walter-Flex-Straße 3\n",
                       "57072 Siegen\n",
                       "Germany" ),
    Place := "Siegen",
    Institution := "Universität Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://github.com/homalg-project/HigherHomologicalAlgebra/tree/master/StableCategories",
PackageInfoURL  := "https://raw.githubusercontent.com/homalg-project/HigherHomologicalAlgebra/master/StableCategories/PackageInfo.g",
README_URL      := "https://raw.githubusercontent.com/homalg-project/HigherHomologicalAlgebra/master/StableCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/StableCategories-", ~.Version, "/StableCategories-", ~.Version ),
# END URLS

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "StableCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Stable categories of additive categories",
),

Dependencies := rec(
  GAP := ">= 4.8",
  NeededOtherPackages := [ [ "CAP", ">= 2020.04.27" ],
                           [ "GAPDoc", ">= 1.5" ],
                            #[ "TriangulatedCategories", ">= 2020.07.15" ],
                            #[ "FrobeniusCategories", ">= 2019.12.06" ],
                            [ "QuotientCategories", ">= 2020.07.05" ],
                            #[ "FreydCategoriesForCAP", ">= 0" ]
                          ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := function()
        return true;
    end,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));