
using CapAndHomalg

LoadPackage( "DerivedCategories" )

SetSpecialSettings( )
EnhanceAllPackages( )

vertices = [ "v1", "v2", "v3", "v4" ];
arrows   = [ "a", "b", "c", "d" ];
sources  = [  1 ,  2 ,  1 ,  3  ];
ranges   = [  2 ,  4 ,  3 ,  4  ];

q = RightQuiver( "quiver", vertices, arrows, sources, ranges )

SetLabelsAsLaTeXStrings( q,
        [ "v_1", "v_2", "v_3", "v_4" ],
        [ "a", "b", "c", "d" ]
    );

q_op = OppositeQuiver( q )
SetLabelsAsLaTeXStrings( q_op,
        [ "v_1", "v_2", "v_3", "v_4" ],
        [ "a", "b", "c", "d" ]
    );

ℚ = HomalgFieldOfRationals( )

ℚq = PathAlgebra( ℚ, q )

Dimension( ℚq )

I = [ 
        ℚq.a * ℚq.b - ℚq.c * ℚq.d,
    ]

𝔸 = ℚq / I

Dimension( 𝔸 )

IsAdmissibleQuiverAlgebra( 𝔸 )

ℚ_vec = MatrixCategory( ℚ )

𝔸oid = Algebroid( 𝔸, range_of_HomStructure = ℚ_vec )

InfoOfInstalledOperationsOfCategory( 𝔸oid )

v1 = 𝔸oid.v1

v2 = 𝔸oid.v2

v3 = 𝔸oid.v3

v4 = 𝔸oid.v4

B_v1_v4 = BasisOfExternalHom( v1, v4 )

mod_𝔸oid = Hom( 𝔸oid, ℚ_vec )

InfoOfInstalledOperationsOfCategory( mod_𝔸oid )

F_v1 = 4 / ℚ_vec
F_v2 = 2 / ℚ_vec
F_v3 = 1 / ℚ_vec
F_v4 = 2 / ℚ_vec

F_a = HomalgMatrix( "[ [ 0, 0 ],
                       [ 1, 0 ],
                       [ 0, 1 ],
                       [ 0, 0 ] ]", 4, 2, ℚ ) / ℚ_vec

F_b = HomalgMatrix( "[ [  0,  1 ],
                       [  0,  0 ] ]", 2, 2, ℚ ) / ℚ_vec

F_c = HomalgMatrix( "[ [ 0 ],
                       [ 1 ],
                       [ 0 ],
                       [ 0 ] ]", 4, 1, ℚ ) / ℚ_vec

F_d = HomalgMatrix( "[ [ 0, 1 ] ]", 1, 2, ℚ ) / ℚ_vec

F = AsObjectInHomCategory(
        𝔸oid,
        [ F_v1, F_v2, F_v3, F_v4 ],
        [ F_a, F_b, F_c, F_d ]
    )

IsWellDefined( F )

m = PreCompose( 𝔸oid."a", 𝔸oid."b" )

F_m = F( m )

G_v1 = 1 / ℚ_vec
G_v2 = 4 / ℚ_vec
G_v3 = 2 / ℚ_vec
G_v4 = 0 / ℚ_vec

G_a = HomalgMatrix( "[ [ 0, 1, 0, 0 ] ]", 1, 4, ℚ ) / ℚ_vec

G_b = HomalgZeroMatrix( 4, 0, ℚ ) / ℚ_vec

G_c = HomalgMatrix( "[ [ 1, 0 ] ]", 1, 2, ℚ ) / ℚ_vec

G_d = HomalgZeroMatrix( 2, 0, ℚ ) / ℚ_vec

G = AsObjectInHomCategory(
        𝔸oid,
        [ G_v1, G_v2, G_v3, G_v4 ],
        [ G_a, G_b, G_c, G_d ]
    )

ψ_v1 = HomalgMatrix( "[ [ 0 ],
                        [ 1 ],
                        [ 0 ],
                        [ 0 ] ]", 4, 1, ℚ ) / ℚ_vec

ψ_v2 = HomalgMatrix( "[ [ 0, 1, 0, 0 ],
                        [ 0, 0, 0, 0 ] ]", 2, 4, ℚ ) / ℚ_vec

ψ_v3 = HomalgMatrix( "[ [ 1, 0 ] ]", 1, 2, ℚ ) / ℚ_vec

ψ_v4 = HomalgZeroMatrix( 2, 0, ℚ ) / ℚ_vec

ψ = AsMorphismInHomCategory( F, [ ψ_v1, ψ_v2, ψ_v3, ψ_v4 ], G )

κ_ψ = KernelEmbedding( ψ )

𝔸oid_op = OppositeAlgebroidOverOppositeQuiverAlgebra( 𝔸oid )

𝕐 = YonedaEmbedding( 𝔸oid_op )

Display( 𝕐 )

P1 = 𝕐( 𝔸oid_op."v1" )

P2 = 𝕐( 𝔸oid_op."v2" )

P3 = 𝕐( 𝔸oid_op."v3" )

P4 = 𝕐( 𝔸oid_op."v4" )

α =  PreCompose( 𝔸oid_op.b, 𝔸oid_op.a )

P_α = 𝕐( α )

projs_0 = FullSubcategoryGeneratedByIndecProjectiveObjects( mod_𝔸oid )

projs_0[ 1 ]

IsEqualForObjects( P1, UnderlyingCell( projs_0[ 1 ] ) )

KnownFunctors( 𝔸oid_op, projs_0 )

𝕐 = Functor( 𝔸oid_op, projs_0, 1 )

𝕐( 𝔸oid_op."v1" )

𝔸op = OppositeAlgebra( 𝔸 )

𝔸op_rows = QuiverRows( 𝔸op )

projs = FullSubcategoryGeneratedByProjectiveObjects( mod_𝔸oid )

KnownFunctors( 𝔸op_rows, projs )

𝕐 = Functor( 𝔸op_rows, projs, 1 )

Display( 𝕐 )

KnownFunctors( projs, 𝔸op_rows )

𝔻 = Functor( projs, 𝔸op_rows, 1 )

Display( 𝔻 )

K = DirectSum( KernelObject( ψ ), CokernelObject( ψ ) )

IsProjective( K )

π_K = EpimorphismFromSomeProjectiveObject( K )

P = Source( π_K )

𝔻P = 𝔻( P / projs )

φ = Sum( BasisOfExternalHom( 𝔻P, 𝔻P ) )

𝕐φ = 𝕐( φ )

GlobalDimensionOfAlgebra( 𝔸, 1 )

GlobalDimensionOfAlgebra( 𝔸, 2 )

𝕂𝕐 = ExtendFunctorToHomotopyCategoriesByCochains( 𝕐 )

Display( 𝕂𝕐 )

K_𝔸op_rows = SourceOfFunctor( 𝕂𝕐 )

K_projs = RangeOfFunctor( 𝕂𝕐 )

𝕂𝔻 = ExtendFunctorToHomotopyCategoriesByCochains( 𝔻 )

Display( 𝕂𝔻 )

ι = InclusionFunctor( projs )
ι = ExtendFunctorToHomotopyCategoriesByCochains( ι )

Display( ι )

K_mod_𝔸oid = RangeOfFunctor( ι )

Ch_mod_𝔸oid = UnderlyingCategory( K_mod_𝔸oid )

𝕃 = LocalizationFunctor( RangeOfFunctor( ι ) )

Display( 𝕃 )

D_mod_𝔸oid = RangeOfFunctor( 𝕃 )

ℙ = LocalizationFunctorByProjectiveObjects( K_mod_𝔸oid )

Display( ℙ )

𝕌 = UniversalFunctorFromDerivedCategory( ℙ )

Display( 𝕌 )

𝔽 = PreCompose( 𝕌, 𝕂𝔻 )

Display( 𝔽 )

𝔾 = PreCompose( [ 𝕂𝕐, ι, 𝕃 ] )

Display( 𝔾 )

C_m1 = QuiverRowsObject(
            [ [ q_op."v4", 1 ] ], 
            𝔸op_rows
        )
C_0 = QuiverRowsObject(
            [ [ q_op."v2", 1 ], [ q_op."v3", 1 ] ], 
            𝔸op_rows
        )
∂_m1 = QuiverRowsMorphism(
            C_m1, 
            [
                [ 𝔸op."b", 𝔸op."d" ],
            ],
            C_0
        )

C = HomotopyCategoryObject( K_𝔸op_rows, [ ∂_m1 ], -1 )

IsWellDefined( C )

𝔾C = 𝔾( C )

IsWellDefined( 𝔾C )

ObjectAt( 𝔾C, -1 )

ObjectAt( 𝔾C, 0 )

∂_m1 = DifferentialAt( 𝔾C, -1 )

CohomologySupport( 𝔾C )

H_0 = CohomologyAt( 𝔾C, 0 )

∂_0 = CokernelProjection( ∂_m1 )

IsEqualForObjects( H_0, Range( ∂_0 ) )

B = DerivedCategoryObject( D_mod_𝔸oid, [ ∂_m1, ∂_0 ], -1 )

IsWellDefined( B )

CohomologySupport( B )

IsZero( B )

𝔽B = 𝔽( B )

IsZero( 𝔽B )

E_1 = P2
E_2 = P3
E_3 = CohomologyAt( 𝔾C, 0 )
E_4 = P1

T = DirectSum( E_1, E_2, E_3, E_4 )

HomStructure( T, T )

T = T / Ch_mod_𝔸oid / K_mod_𝔸oid / D_mod_𝔸oid

HomStructure( T, Shift( T, 0 ) )

HomStructure( T, Shift( T, 1 ) )

HomStructure( T, Shift( T, 2 ) )

𝔽T = 𝔽( T )

HomStructure( 𝔽T, Shift( 𝔽T, 0 ) )

HomStructure( 𝔽T, Shift( 𝔽T, 1 ) )

HomStructure( 𝔽T, Shift( 𝔽T, 2 ) )

E = CreateStrongExceptionalCollection( [ E_1, E_2, E_3, E_4 ], [ "[0101]", "[0011]", "[0111]", "[1111]" ] )

EndT = EndomorphismAlgebra( E )

QuiverOfAlgebra( EndT )

RelationsOfAlgebra( EndT )

Dimension( EndT )

IsAdmissibleQuiverAlgebra( EndT )

EndT_oid = Algebroid( E )

Abs = IsomorphismOntoAlgebroid( E )

Abs( E[ 1 ] )

Rel = IsomorphismFromAlgebroid( E )

Rel( EndT_oid."[1111]" )

Rel( EndT_oid."[1111]" ) == E[ 4 ]

m = Rel( EndT_oid."m3_4_1" )

Source( m ) == E[ 3 ] && Range( m ) == E[ 4 ] && m == BasisOfPaths( E, 3, 4 )[ 1 ]

E_plus = AdditiveClosure( E )

EndT_oid_plus = QuiverRows( EndT )

EndT_oid_op = OppositeAlgebroidOverOppositeQuiverAlgebra( EndT_oid )

mod_EndT_oid_op = Hom( EndT_oid_op, ℚ_vec )

projs = FullSubcategoryGeneratedByProjectiveObjects( mod_EndT_oid_op )

Hom_T = HomFunctorToCategoryOfFunctors( E )

Display( Hom_T )

tensor_T = TensorFunctorFromCategoryOfFunctors( E )

Display( tensor_T )

η = CounitOfTensorHomAdjunction( E, tensor_T, Hom_T )

Hom_T = ExtendFunctorToHomotopyCategories( Hom_T, true )
tensor_T = ExtendFunctorToHomotopyCategories( tensor_T, true )
η = ExtendNaturalTransformationToHomotopyCategories( η, true )

Display( Hom_T )

Display( tensor_T )

K = P4 / Ch_mod_𝔸oid / K_mod_𝔸oid

Inj_K = InjectiveResolution( K, true )

Inj_K[0]

Inj_K[1]

Inj_K[2]

Hom_T_Inj_K = Hom_T( Inj_K )

Prj_Hom_T_Inj_K = ProjectiveResolution( Hom_T_Inj_K, true )

q_Prj_Hom_T_Inj_K = QuasiIsomorphismFromProjectiveResolution( Hom_T_Inj_K, true )

IsWellDefined( q_Prj_Hom_T_Inj_K ) & IsQuasiIsomorphism( q_Prj_Hom_T_Inj_K )

tensor_T_Prj_Hom_T_Inj_K = tensor_T( ProjectiveResolution( Hom_T( Inj_K ), true ) )

tensor_T_Prj_Hom_T_Inj_K[0]

tensor_T_Prj_Hom_T_Inj_K[1]

tensor_T_Prj_Hom_T_Inj_K[2]

ι_Inj_K = PreCompose( tensor_T( q_Prj_Hom_T_Inj_K ), η( Inj_K ) )

IsWellDefined( ι_Inj_K )

IsQuasiIsomorphism( ι_Inj_K )

( Source( ι_Inj_K ) == tensor_T_Prj_Hom_T_Inj_K ) & ( Range( ι_Inj_K ) == Inj_K )

K_EndT_oid_plus = HomotopyCategory( EndT_oid_plus, true )

𝕃p = LocalizationFunctorByProjectiveObjects( RangeOfFunctor( Hom_T ) )

K_projs_mod_EndT_op = RangeOfFunctor( 𝕃p )

KnownFunctors( K_projs_mod_EndT_op, K_EndT_oid_plus )

𝕄 = Functor( K_projs_mod_EndT_op, K_EndT_oid_plus, 1 )

𝕏 = PreCompose( [ Hom_T, 𝕃p, 𝕄 ] )

Display( 𝕏 )

𝕏_Inj_K = 𝕏( Inj_K )

s = SimplifyObject( 𝕏_Inj_K, infinity )

i = SimplifyObject_IsoToInputObject( 𝕏_Inj_K, infinity )

j = InverseForMorphisms( i )