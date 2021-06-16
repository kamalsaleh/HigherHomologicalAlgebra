gap> quiver := RightQuiver( "quiver", 3, [ [ "x0", 1, 2 ], [ "x1", 1, 2 ], [ "x2", 1, 2 ], [ "y0", 2, 3 ], [ "y1", 2, 3 ], [ "y2", 2, 3 ] ] );;
gap> field := GLOBAL_FIELD_FOR_QPA!.default_field;;
gap> Qq := PathAlgebra( field, quiver );;
gap> A :=
>   QuotientOfPathAlgebra(
>     Qq,
>     [
>       Qq.x0 * Qq.y0 ,
>       Qq.x1 * Qq.y1 ,
>       Qq.x2 * Qq.y2 ,
>       Qq.x0 * Qq.y1 + Qq.x1 * Qq.y0,
>       Qq.x0 * Qq.y2 + Qq.x2 * Qq.y0,
>       Qq.x1 * Qq.y2 + Qq.x2 * Qq.y1,
>     ] 
> );;
gap> T := [ ];;
gap> mats :=
>   [ [ [ 1, 0, 0 ] ], [ [ 0, 1, 0 ] ], [ [ 0, 0, 1 ] ], [ [ 0, 0, 0 ], [ -1, 0, 0 ], [ 0, -1, 0 ] ], [ [ 1, 0, 0 ], [ 0, 0, 0 ], [ 0, 0, -1 ] ],
>     [ [ 0, 1, 0 ], [ 0, 0, 1 ], [ 0, 0, 0 ] ] ];;
gap> mats := List( mats, m -> MatrixByRows( field, m ) );;
gap> Add( T, QuiverRepresentation( A, [ 1, 3, 3 ], mats ) );;
gap> mats := 
> [ [ [ 0, 0, 0, -1, 0, 0, 0, -1 ], [ 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0 ] ], 
>   [ [ 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0 ] ],
>   [ [ 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1 ] ],
>   [ [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ] ], [ [ 0, 0, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ],
>       [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ] ],
>   [ [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0 ], 
>       [ 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 0, 0 ] ] ];;
gap> mats := List( mats, m -> MatrixByRows( field, m ) );;
gap> Add( T, QuiverRepresentation( A, [ 3, 8, 6 ], mats ) );; 
gap> mats :=
> [ [ [ 0, 0, -1, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, -1 ],
>       [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ] ],
>   [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ] ],
>   [ [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ] ],
>   [ [ 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ],
>       [ 0, 0, 0, -1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, -1, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, -1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, -1, 0 ] ],
>   [ [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, -1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 1, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, -1 ] ],
>   [ [ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 1, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
>       [ 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ] ] ];;
gap> mats := List( mats, m -> MatrixByRows( field, m ) );;
gap> Add( T, QuiverRepresentation( A, [ 6, 15, 10 ], mats ) );;
gap> collection := CreateStrongExceptionalCollection( T );;
gap> HH := HomFunctor( collection );;
gap> C := AsCapCategory( Source( HH ) );;
gap> D := AsCapCategory( Range( HH ) );;
gap> eta := CounitOfTensorHomAdjunction( collection );;
gap> lambda := UnitOfTensorHomAdjunction( collection );;
gap> alpha := RandomMorphism( C, 3 );;
gap> CheckNaturality( eta, alpha );
true
gap> alpha := RandomMorphism( D, 3 );;
gap> CheckNaturality( lambda, alpha );
true