function( alpha )
  
  St_A_GRows_E := CapCategory( alpha );
  A_GRows_E := UnderlyingCategory( St_A_GRows_E );
  GRows_E := UnderlyingCategory( A_GRows_E );
  
  alpha := UnderlyingCell( alpha );
  
  A := Source( alpha );
  B := Range( alpha );
  C := UnderlyingCell( StandardConeObject( alpha / St_A_GRows_E ) );
  inf_C := InflationIntoSomeExactInjectiveObject( C );
  I_C := Range( inf_C );
  def_C := DeflationFromSomeExactProjectiveObject( C );
  P_C := Source( def_C );
  
  I := DirectSum( I_C, P_C );
  
  i := Random( BasisOfExternalHom( C, I ) );
  j := Random( BasisOfExternalHom( I, C ) );
  
  i := MorphismBetweenDirectSums( [ [ i, IdentityMorphism( C ) ] ] );
  j := MorphismBetweenDirectSums( [ [ j ], [ IdentityMorphism( C ) ] ] );
  
  beta := PreCompose( UnderlyingCell( MorphismToStandardConeObject( alpha / St_A_GRows_E ) ), i );
  gamma := PreCompose( j, UnderlyingCell( MorphismFromStandardConeObject( alpha / St_A_GRows_E ) ) );
  C := Source( gamma );
  
  t := ExactTriangle( alpha / St_A_GRows_E, beta / St_A_GRows_E, gamma / St_A_GRows_E );
   
  rot_t := Rotation( t );
  IsWellDefined( rot_t );
  n := UnderlyingCell( WitnessIsomorphismOntoStandardExactTriangle(rot_t)[2] );
  m := UnderlyingCell( Inverse( n / St_A_GRows_E ) );
  
  tau := UnderlyingCell( Range( WitnessIsomorphismOntoStandardExactTriangle(rot_t) )^1 );
  lambda := UnderlyingCell( Range( WitnessIsomorphismOntoStandardExactTriangle(rot_t) )^2 );
  
  m_sigma_alpha := UnderlyingCell( rot_t^2 );
  
  MAKE_READ_WRITE_GLOBAL( "E" );
  sigma_A := Range( gamma );
  E := Range( t );
  
  epsilon := - InjectionOfCofactorOfExactPushout( iota_B, beta, 1 );
  epsilon_tau := MorphismBetweenDirectSums( [ [ epsilon ], [ tau ] ] );
  
  m_pi_B := -CompleteInflationToConflation( iota_B );
  I_B := Range( iota_B );
  sigma_B := Range( lambda );
  m_pi_B_0 := MorphismBetweenDirectSums( [ [ -pi_B ], [ ZeroMorphism( C, sigma_B ) ] ] );
  0_gamma := MorphismBetweenDirectSums( [ [ ZeroMorphism(I_B, sigma_A ) ], [ gamma ] ] );
  
  
  g := CompleteInflationToConflation( epsilon );
  f := Section( g );
  
  fm := f * m;
  E_prim := Range( g );
  iota_A := InflationIntoSomeExactInjectiveObject( A );
  pi_A := CompleteInflationToConflation( iota_A );
  
end;
