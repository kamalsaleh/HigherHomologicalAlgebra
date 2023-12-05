gap> seq := RandomStrongExceptionalSequence( HomalgFieldOfRationals(), 5, 20, 10 );;
gap> abs := AbstractionAlgebroid( seq );;
gap> oid := UnderlyingCategory( DefiningCategory( AmbientCategory( seq ) ) );;
gap> Assert( 0, Dimension( abs ) = Dimension( oid ) );
