#
# QuotientCategories: Quotient categories of CAP categories by two-sided ideals
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "QuotientCategories",
Subtitle := "Quotient categories of CAP categories by two-sided ideals",
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
               "57068 Siegen\n",
               "Germany" ),
    Place := "Siegen",
    Institution := "University of Siegen",
  ),
],

# BEGIN URLS
SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/homalg-project/HigherHomologicalAlgebra",
),
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://github.com/homalg-project/HigherHomologicalAlgebra/tree/master/QuotientCategories",
PackageInfoURL  := "https://raw.githubusercontent.com/homalg-project/HigherHomologicalAlgebra/master/QuotientCategories/PackageInfo.g",
README_URL      := "https://raw.githubusercontent.com/homalg-project/HigherHomologicalAlgebra/master/QuotientCategories/README.md",
ArchiveURL      := Concatenation( "https://github.com/homalg-project/HigherHomologicalAlgebra/releases/download/QuotientCategories-", ~.Version, "/QuotientCategories-", ~.Version ),
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
  BookName  := "QuotientCategories",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Quotient categories of CAP categories by two-sided ideals",
),

Dependencies := rec(
  GAP := ">= 4.9",
  NeededOtherPackages := [
                [ "AutoDoc", ">=2018.02.14" ],
                [ "CAP", ">=2020.01.03" ],
                [ "CategoryConstructor", ">= 2020.04.05" ]
                ],
  SuggestedOtherPackages := [ ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

#Keywords := [ "TODO" ],

));