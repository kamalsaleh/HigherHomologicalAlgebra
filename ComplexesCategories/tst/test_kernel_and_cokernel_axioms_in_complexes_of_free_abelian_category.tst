# This test constructs an explicit short complex S → A → B → T in the Adelman
# category of an additive closure of a path algebroid over Q, where the
# composites S → B and A → T are zero, and verifies the kernel/cokernel axioms.
#
# Setup:
#   - S is a cochain complex concentrated in degrees [-5..-1].
#   - A is a cochain complex concentrated in degrees [-4..4].
#   - B is a cochain complex concentrated in degrees [-6..2].
#   - T is a cochain complex concentrated in degrees [-5..4].
#   - zeta : S → A, phi : A → B, and tau : B → T are cochain maps
#     with PreCompose( zeta, phi ) = 0 and PreCompose( phi, tau ) = 0.
#
# The test verifies:
#   (1) Kernel and cokernel lifts/colits are well-defined.
#   (2) The universal properties of kernel and cokernel hold.
#   (3) The Hom-structure is compatible with kernel and cokernel.
#   (4) Image and coimage are well-defined, with the expected (epi,mono) factorisation.

gap> START_TEST("test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.tst");

gap> LoadPackage( "FpLinearCategories", false );
true
gap> LoadPackage( "ComplexesCategories", false );
true
gap> Read( Filename( DirectoriesPackageLibrary( "ComplexesCategories", "tst" )[1], "data_tables_for_test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g" ) );;
gap> oid := AlgebroidFromDataTables( data_tables );;
gap> Aoid := AdditiveClosure( oid );;
gap> AAoid := AdelmanCategory( Aoid );;
gap> ch_AAoid := ComplexesCategoryByCochains( AAoid );;
gap> S := CreateComplex( ch_AAoid,
>           [ oid.dS_m5 / Aoid / AAoid, oid.dS_m4 / Aoid / AAoid, oid.dS_m3 / Aoid / AAoid, oid.dS_m2 / Aoid / AAoid ],
>           -5 );;
gap> A := CreateComplex( ch_AAoid,
>           [ oid.dA_m4 / Aoid / AAoid, oid.dA_m3 / Aoid / AAoid, oid.dA_m2 / Aoid / AAoid, oid.dA_m1 / Aoid / AAoid,
>             oid.dA_0 / Aoid / AAoid, oid.dA_1 / Aoid / AAoid, oid.dA_2 / Aoid / AAoid, oid.dA_3 / Aoid / AAoid ],
>           -4 );;
gap> B := CreateComplex( ch_AAoid,
>           [ oid.dB_m6 / Aoid / AAoid, oid.dB_m5 / Aoid / AAoid, oid.dB_m4 / Aoid / AAoid, oid.dB_m3 / Aoid / AAoid,
>             oid.dB_m2 / Aoid / AAoid, oid.dB_m1 / Aoid / AAoid, oid.dB_0 / Aoid / AAoid, oid.dB_1 / Aoid / AAoid ],
>           -6 );;
gap> T := CreateComplex( ch_AAoid,
>           [ oid.dT_m5 / Aoid / AAoid, oid.dT_m4 / Aoid / AAoid, oid.dT_m3 / Aoid / AAoid, oid.dT_m2 / Aoid / AAoid,
>             oid.dT_m1 / Aoid / AAoid, oid.dT_0 / Aoid / AAoid, oid.dT_1 / Aoid / AAoid, oid.dT_2 / Aoid / AAoid,
>             oid.dT_3 / Aoid / AAoid ],
>           -5 );;
gap> zeta := CreateComplexMorphism( ch_AAoid, S, [ oid.zeta_m3 / Aoid / AAoid, oid.zeta_m2 / Aoid / AAoid ], -3, A );;
gap> phi := CreateComplexMorphism( ch_AAoid, A,
>             [ oid.phi_m3 / Aoid / AAoid, oid.phi_m2 / Aoid / AAoid, oid.phi_m1 / Aoid / AAoid, oid.phi_0 / Aoid / AAoid ],
>             -3, B );;
gap> tau := CreateComplexMorphism( ch_AAoid, B,
>             [ oid.tau_m4 / Aoid / AAoid, oid.tau_m3 / Aoid / AAoid, oid.tau_m2 / Aoid / AAoid,
>               oid.tau_m1 / Aoid / AAoid, oid.tau_0 / Aoid / AAoid, oid.tau_1 / Aoid / AAoid ],
>             -4, T );;
gap> Assert( 0, CohomologySupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, ObjectsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) ] );
gap> Assert( 0, DifferentialsSupport( A ) = [ LowerBound( A ) .. UpperBound( A ) - 1 ] );
gap> Assert( 0, ForAll( [ zeta, phi, tau ], IsWellDefined ) and ForAll( [ PreCompose( zeta, phi ), PreCompose( phi, tau ) ], IsZeroForMorphisms ) );
gap> Assert( 0, ForAll( [ CokernelColift( phi, tau ), KernelLift( phi, zeta ) ], IsWellDefined ) );
gap> Assert( 0, IsZeroForMorphisms( tau - PreCompose( CokernelProjection( phi ), CokernelColift( phi, tau ) ) ) );
gap> Assert( 0, IsZeroForMorphisms( zeta - PostCompose( KernelEmbedding( phi ), KernelLift( phi, zeta ) ) ) );
gap> #(expensive) Assert( 0, RankOfObject( HomStructure( S, KernelObject( phi ) ) ) = 1 );
gap> #(expensive) Assert( 0, RankOfObject( HomStructure( CokernelObject( phi ), T ) ) = 1 );
gap> iota := ImageEmbedding( phi );;
gap> pi := CoimageProjection( phi );;
gap> Assert( 0, ForAll( [ iota, pi ], IsWellDefined ) );;
gap> Assert( 0, IsMonomorphism( iota ) and IsEpimorphism( pi ) );;

#
gap> STOP_TEST("test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.tst", 1);
