#! @Chunk freyd_categories_graded_exterior_algebra

LoadPackage( "FreydCategoriesForCAP" );
LoadPackage( "StableCategories" );
LoadPackage( "ModulePresentations" );

EnhancePackage( "FreydCategoriesForCAP" );

#! @Example
Q := HomalgFieldOfRationalsInSingular( );;
S := GradedRing( Q * "x,y" );
WeightsOfIndeterminates( S );
A := KoszulDualRing( S );
rows_A := CategoryOfRows( A );

#! @EndExample
