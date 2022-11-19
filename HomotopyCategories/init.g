# SPDX-License-Identifier: GPL-2.0-or-later
# HomotopyCategories: Homotopy categories of additive categories
#
# Reading the declaration part of the package.
#

ReadPackage( "HomotopyCategories", "gap/Categories.gd");
ReadPackage( "HomotopyCategories", "gap/Objects.gd");
ReadPackage( "HomotopyCategories", "gap/Morphisms.gd");
ReadPackage( "HomotopyCategories", "gap/HomStructure.gd");
ReadPackage( "HomotopyCategories", "gap/TriangulatedStructure.gd" );

#ReadPackage( "HomotopyCategories", "gap/Functors.gd" );
#ReadPackage( "HomotopyCategories", "gap/Convolution.gd" );
#ReadPackage( "HomotopyCategories", "gap/ImportedMethods.gd" );

#if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
#    ReadPackage( "HomotopyCategories", "gap/Julia.gd" );
#fi;
