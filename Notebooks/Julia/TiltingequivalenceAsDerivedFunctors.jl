
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

ρ = [ 
        ℚq.a * ℚq.b - ℚq.c * ℚq.d,
    ]

𝔸 = ℚq / ρ

Dimension( 𝔸 )

IsAdmissibleQuiverAlgebra( 𝔸 )

ℚ_vec = MatrixCategory( ℚ )

𝔸oid = Algebroid( 𝔸, range_of_HomStructure = ℚ_vec )

InfoOfInstalledOperationsOfCategory( 𝔸oid )

v1 = 𝔸oid."v1"

v2 = 𝔸oid."v2"

v3 = 𝔸oid."v3"

v4 = 𝔸oid."v4"

SetOfObjects( 𝔸oid )

RangeCategoryOfHomomorphismStructure( 𝔸oid )

HomStructure( v1, v4 )

B_v1_v4 = BasisOfExternalHom( v1, v4 )

b = 𝔸oid."b"


SetOfGeneratingMorphisms( 𝔸oid )

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


IsMonomorphism( ψ )

IsEpimorphism( ψ )

K_ψ = KernelObject( ψ )


κ_ψ = KernelEmbedding( ψ )


RangeCategoryOfHomomorphismStructure( mod_𝔸oid )

HomStructure( F, G )

HomStructure( G, F )

Hom_GF = BasisOfExternalHom( G, F );

τ = -5 * Hom_GF[3] + 2 * Hom_GF[5] + 15 * Hom_GF[6]


CoefficientsOfMorphism( τ )

P_F = SomeProjectiveObject( F )

IsProjective( P_F )


π_F = EpimorphismFromSomeProjectiveObject( F )


I_F = SomeInjectiveObject( F )

IsInjective( I_F )


ι_F = MonomorphismIntoSomeInjectiveObject( F )


𝔸oid_op = OppositeAlgebroidOverOppositeQuiverAlgebra( 𝔸oid )

𝕐 = YonedaEmbedding( 𝔸oid_op )

Display( 𝕐 )

IsIdenticalObj( RangeOfFunctor( 𝕐 ), mod_𝔸oid )

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

Display( 𝕐 )

𝕐( 𝔸oid_op."v1" )

𝔸op = OppositeAlgebra( 𝔸 )

𝔸oid_op_plus = AdditiveClosure( 𝔸oid_op )

InfoOfInstalledOperationsOfCategory( 𝔸oid_op_plus )

projs = FullSubcategoryGeneratedByProjectiveObjects( mod_𝔸oid )

InfoOfInstalledOperationsOfCategory( projs )

RangeCategoryOfHomomorphismStructure( 𝔸oid_op_plus )

RangeCategoryOfHomomorphismStructure( projs )

KnownFunctors( 𝔸oid_op_plus, projs )

𝕐 = Functor( 𝔸oid_op_plus, projs, 1 )

Display( 𝕐 )

KnownFunctors( projs, 𝔸oid_op_plus )

𝔻 = Functor( projs, 𝔸oid_op_plus, 1 )

Display( 𝔻 )

K = DirectSum( KernelObject( ψ ), CokernelObject( ψ ) )

IsProjective( K )

P = SomeProjectiveObject( K )


P =  P / projs

𝔻_P = 𝔻( P )


HomStructure( 𝔻_P, 𝔻_P )

φ = Sum( BasisOfExternalHom( 𝔻_P, 𝔻_P ) )


𝕐_φ = 𝕐( φ )


𝔻( 𝕐_φ ) == φ

GlobalDimensionOfAlgebra( 𝔸, 1 )

GlobalDimensionOfAlgebra( 𝔸, 2 )

K_𝔸oid_op_plus = HomotopyCategoryByCochains( 𝔸oid_op_plus )

K_projs = HomotopyCategoryByCochains( projs )

RangeCategoryOfHomomorphismStructure( K_𝔸oid_op_plus )

RangeCategoryOfHomomorphismStructure( K_projs )

Display( 𝕐 )

K_𝕐 = ExtendFunctorToHomotopyCategoriesByCochains( 𝕐 )

Display( K_𝕐 )

IsIdenticalObj( SourceOfFunctor( K_𝕐 ), K_𝔸oid_op_plus ) && IsIdenticalObj( K_projs, RangeOfFunctor( K_𝕐 ) )

Display( 𝔻 )

K_𝔻 = ExtendFunctorToHomotopyCategoriesByCochains( 𝔻 )

Display( K_𝔻 )

IsIdenticalObj( SourceOfFunctor( K_𝔻 ), K_projs ) && IsIdenticalObj( K_𝔸oid_op_plus, RangeOfFunctor( K_𝔻 ) )

Ch_mod_𝔸oid = CochainComplexCategory( mod_𝔸oid )

K_mod_𝔸oid = HomotopyCategoryByCochains( mod_𝔸oid )

D_mod_𝔸oid = DerivedCategory( mod_𝔸oid, true )

IsIdenticalObj( mod_𝔸oid, AmbientCategory( projs ) )

ι = InclusionFunctor( projs );

𝕀 = ExtendFunctorToHomotopyCategoriesByCochains( ι )

Display( 𝕀 )

IsIdenticalObj( K_mod_𝔸oid, RangeOfFunctor( 𝕀 ) )

𝕃 = LocalizationFunctor( K_mod_𝔸oid )

Display( 𝕃 )

IsIdenticalObj( D_mod_𝔸oid, RangeOfFunctor( 𝕃 ) )

ℙroj = LocalizationFunctorByProjectiveObjects( K_mod_𝔸oid )

Display( ℙroj )

𝕌 = UniversalFunctorFromDerivedCategory( ℙroj )

Display( 𝕌 )

𝕌K_𝔻 = PreCompose( 𝕌, K_𝔻 )

Display( 𝕌K_𝔻 )

K_𝕐𝕀𝕃 = PreCompose( [ K_𝕐, 𝕀, 𝕃 ] )

Display( K_𝕐𝕀𝕃 )

C_m1 = AdditiveClosureObject(
            [ 𝔸oid_op."v4" ], 
            𝔸oid_op_plus
        )
C_0 = AdditiveClosureObject(
            [ 𝔸oid_op."v2", 𝔸oid_op."v3" ], 
            𝔸oid_op_plus
        )
∂_m1 = AdditiveClosureMorphism(
            C_m1, 
            [
                [ 𝔸oid_op."b", 𝔸oid_op."d" ],
            ],
            C_0
        )


C = HomotopyCategoryObject( K_𝔸oid_op_plus, [ ∂_m1 ], -1 )


IsWellDefined( C )

W = K_𝕐𝕀𝕃( C )

IsWellDefined( W )

ObjectAt( W, -1 )

ObjectAt( W, 0 )

∂_m1 = DifferentialAt( W, -1 )


CohomologySupport( W )

H_0 = CohomologyAt( W, 0 )


∂_0 = CokernelProjection( ∂_m1 )


IsEqualForObjects( H_0, Range( ∂_0 ) )

B = DerivedCategoryObject( D_mod_𝔸oid, [ ∂_m1, ∂_0 ], -1 )

IsWellDefined( B )

CohomologySupport( B )

IsZero( B )

𝕌K_𝔻_B = 𝕌K_𝔻( B )


IsZero( 𝕌K_𝔻_B )

E_1 = P2
E_2 = P3
E_3 = CohomologyAt( W, 0 )
E_4 = P1

T = DirectSum( E_1, E_2, E_3, E_4 )


HomStructure( T, T )

T = T / Ch_mod_𝔸oid / K_mod_𝔸oid / D_mod_𝔸oid

Shift( T, 1 )

HomStructure( T, Shift( T, 0 ) )

HomStructure( T, Shift( T, 1 ) )

HomStructure( T, Shift( T, 2 ) )

𝕌K_𝔻T = 𝕌K_𝔻( T )


HomStructure( 𝕌K_𝔻T, Shift( 𝕌K_𝔻T, 0 ) )

HomStructure( 𝕌K_𝔻T, Shift( 𝕌K_𝔻T, 1 ) )

HomStructure( 𝕌K_𝔻T, Shift( 𝕌K_𝔻T, 2 ) )

E = CreateStrongExceptionalCollection( [ E_1, E_2, E_3, E_4 ], [ "[0101]", "[0011]", "[0111]", "[1111]" ] )

EndT = EndomorphismAlgebra( E )

qEndT = QuiverOfAlgebra( EndT )

v1 = Vertex( qEndT, 1 )

v1 == qEndT."[0101]"

m1_3_1 = qEndT."m1_3_1"

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


m = Rel( EndT_oid."m2_3_1" )

Source( m ) == E[ 2 ] && Range( m ) == E[ 3 ] && m == BasisOfPaths( E, 2, 3 )[ 1 ]


m = Rel( EndT_oid."m1_3_1" )

Source( m ) == E[ 1 ] && Range( m ) == E[ 3 ] && m == BasisOfPaths( E, 1, 3 )[ 1 ]


E_plus = AdditiveClosure( E )

EndT_oid_plus = AdditiveClosure( EndT_oid )

Abs_plus = ExtendFunctorToAdditiveClosures( Abs )

Rel_plus = ExtendFunctorToAdditiveClosures( Rel )

EndT_oid_op = OppositeAlgebroidOverOppositeQuiverAlgebra( EndT_oid )

mod_EndT_oid_op = Hom( EndT_oid_op, ℚ_vec )

InfoOfInstalledOperationsOfCategory( mod_EndT_oid_op )

projs = FullSubcategoryGeneratedByProjectiveObjects( mod_EndT_oid_op )

KnownFunctors( EndT_oid_plus, projs )

KnownFunctors( projs, EndT_oid_plus )

K_Abs_plus = ExtendFunctorToHomotopyCategoriesByCochains( Abs_plus )

Display( K_Abs_plus )

K_Rel_plus = ExtendFunctorToHomotopyCategoriesByCochains( Rel_plus )

Display( K_Rel_plus )

ζ = InclusionFunctor( DefiningFullSubcategory( E ) );
ζ = ExtendFunctorToAdditiveClosureOfSource( ζ );
ζ = ExtendFunctorToHomotopyCategoriesByCochains( ζ )

Display( ζ )

N = RandomObject( SourceOfFunctor( K_Rel_plus ), julia_to_gap( [ -1, 1, 2 ] ) )


N = ζ( K_Rel_plus( N ) )

N[-1]

N[0]

N[1]

mod_𝔸oid

mod_EndT_oid_op

Hom_T = HomFunctorToCategoryOfFunctors( E )

Display( Hom_T )

tensor_T = TensorFunctorFromCategoryOfFunctors( E )

Display( tensor_T )

ϵ = CounitOfTensorHomAdjunction( E, tensor_T, Hom_T )

η = UnitOfTensorHomAdjunction( E, tensor_T, Hom_T )

F

tensor_T_Hom_T_F = tensor_T( Hom_T( F ) )


ϵ_F = ϵ( F )

Source( ϵ_F ) == tensor_T_Hom_T_F && Range( ϵ_F ) == F


PreCompose( ϵ( F ), ψ ) == PreCompose( tensor_T( Hom_T( ψ ) ), ϵ( G ) )

Hom_T = ExtendFunctorToHomotopyCategoriesByCochains( Hom_T )
tensor_T = ExtendFunctorToHomotopyCategoriesByCochains( tensor_T )
ϵ = ExtendNaturalTransformationToHomotopyCategories( ϵ, true )

Display( Hom_T )

Display( tensor_T )

K = P4 / Ch_mod_𝔸oid / K_mod_𝔸oid

Inj_K = InjectiveResolution( K, true )

Inj_K[0]

Inj_K[1]

Inj_K[2]

Hom_T_Inj_K = Hom_T( Inj_K )

Proj_Hom_T_Inj_K = ProjectiveResolution( Hom_T_Inj_K, true )

q_Proj_Hom_T_Inj_K = QuasiIsomorphismFromProjectiveResolution( Hom_T_Inj_K, true )

IsWellDefined( q_Proj_Hom_T_Inj_K ) & IsQuasiIsomorphism( q_Proj_Hom_T_Inj_K )

tensor_T_Proj_Hom_T_Inj_K = tensor_T( ProjectiveResolution( Hom_T( Inj_K ), true ) )

tensor_T_Proj_Hom_T_Inj_K[0]

tensor_T_Proj_Hom_T_Inj_K[1]

tensor_T_Proj_Hom_T_Inj_K[2]

ι_Inj_K = PreCompose( tensor_T( q_Proj_Hom_T_Inj_K ), ϵ( Inj_K ) )

( Source( ι_Inj_K ) == tensor_T_Proj_Hom_T_Inj_K ) & ( Range( ι_Inj_K ) == Inj_K )

IsWellDefined( ι_Inj_K )

IsQuasiIsomorphism( ι_Inj_K )

EndT_oid_plus

K_EndT_oid_plus = HomotopyCategoryByCochains( EndT_oid_plus )

K_mod_EndT_oid_op = HomotopyCategoryByCochains( mod_EndT_oid_op )

𝕃p = LocalizationFunctorByProjectiveObjects( K_mod_EndT_oid_op )

K_projs_mod_EndT_op = RangeOfFunctor( 𝕃p )

KnownFunctors( K_projs_mod_EndT_op, K_EndT_oid_plus )

𝔻 = Functor( K_projs_mod_EndT_op, K_EndT_oid_plus, 1 )

ℝ = PreCompose( [ Hom_T, 𝕃p, 𝔻 ] )

Display( ℝ )

ℝ_Inj_K = ℝ( Inj_K )


s = SimplifyObject( ℝ_Inj_K, infinity )


i = SimplifyObject_IsoToInputObject( ℝ_Inj_K, infinity )


j = InverseForMorphisms( i )


ζ_K_Rel_plus_i = ζ( K_Rel_plus( i ) )

IsIsomorphism( ζ_K_Rel_plus_i )

Range( ζ_K_Rel_plus_i ) == tensor_T_Proj_Hom_T_Inj_K


