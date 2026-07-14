# gen_test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g
#
# PURPOSE:
#   Computes the data tables of the path-algebra quotient encoding the diagram
#
#       S --zeta--> A --phi--> B --tau--> T
#
#   and writes them, together with the field k and the resulting algebroid oid,
#   into the companion file
#       test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g
#
#   That companion file is read by the corresponding .tst file so that the
#   expensive computation (DataTablesOfLinearCategory) is done only once.
#
# USAGE (from the repository root or this directory):
#   gap tst/gen_test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g
#
# WHAT THIS SCRIPT DOES:
#   1. Builds the quiver q with four chain complexes S, A, B, T as objects at
#      each degree, and the differentials / natural-transformation components as
#      arrows.
#   2. Imposes the relations:
#        - d^2 = 0 for every complex (chain-complex axiom)
#        - naturality squares for zeta, phi, tau
#        - zeta*phi = 0  and  phi*tau = 0  (the sequence is a complex)
#   3. Calls DataTablesOfLinearCategory on the resulting k-linear quotient
#      category.
#   4. Serialises the data tables to the companion .g file.

LoadPackage( "FpLinearCategories", false );

# ── 1. Coefficient field ────────────────────────────────────────────────────

k := HomalgFieldOfRationals( );;

# ── 2. Quiver ────────────────────────────────────────────────────────────────
# Objects  : one vertex per degree slot of each complex
#   S in degrees [-5..-1]  →  S_m5, S_m4, S_m3, S_m2, S_m1
#   A in degrees [-4.. 4]  →  A_m4, ..., A_4
#   B in degrees [-6.. 2]  →  B_m6, ..., B_2
#   T in degrees [-5.. 4]  →  T_m5, ..., T_4
# Arrows   : differentials dX_i : X_i -> X_{i+1}
#            components of zeta, phi, tau in the overlapping degree range

q := FinQuiver(
  "q(S_m5,S_m4,S_m3,S_m2,S_m1,\
      A_m4,A_m3,A_m2,A_m1,A_0,A_1,A_2,A_3,A_4,\
      B_m6,B_m5,B_m4,B_m3,B_m2,B_m1,B_0,B_1,B_2,\
      T_m5,T_m4,T_m3,T_m2,T_m1,T_0,T_1,T_2,T_3,T_4)\
  [dS_m5:S_m5->S_m4,dS_m4:S_m4->S_m3,dS_m3:S_m3->S_m2,dS_m2:S_m2->S_m1,\
   dA_m4:A_m4->A_m3,dA_m3:A_m3->A_m2,dA_m2:A_m2->A_m1,dA_m1:A_m1->A_0,\
   dA_0:A_0->A_1,dA_1:A_1->A_2,dA_2:A_2->A_3,dA_3:A_3->A_4,\
   dB_m6:B_m6->B_m5,dB_m5:B_m5->B_m4,dB_m4:B_m4->B_m3,dB_m3:B_m3->B_m2,\
   dB_m2:B_m2->B_m1,dB_m1:B_m1->B_0,dB_0:B_0->B_1,dB_1:B_1->B_2,\
   dT_m5:T_m5->T_m4,dT_m4:T_m4->T_m3,dT_m3:T_m3->T_m2,dT_m2:T_m2->T_m1,\
   dT_m1:T_m1->T_0,dT_0:T_0->T_1,dT_1:T_1->T_2,dT_2:T_2->T_3,dT_3:T_3->T_4,\
   zeta_m3:S_m3->A_m3,zeta_m2:S_m2->A_m2,\
   phi_m3:A_m3->B_m3,phi_m2:A_m2->B_m2,phi_m1:A_m1->B_m1,phi_0:A_0->B_0,\
   tau_m4:B_m4->T_m4,tau_m3:B_m3->T_m3,tau_m2:B_m2->T_m2,\
   tau_m1:B_m1->T_m1,tau_0:B_0->T_0,tau_1:B_1->T_1]" );;

F  := PathCategory( q );;
kF := k[F];;

# ── 3. Relations ─────────────────────────────────────────────────────────────

rels := [

  # d^2 = 0  for S
  PreCompose( kF.dS_m5, kF.dS_m4 ),
  PreCompose( kF.dS_m4, kF.dS_m3 ),
  PreCompose( kF.dS_m3, kF.dS_m2 ),

  # d^2 = 0  for A
  PreCompose( kF.dA_m4, kF.dA_m3 ),
  PreCompose( kF.dA_m3, kF.dA_m2 ),
  PreCompose( kF.dA_m2, kF.dA_m1 ),
  PreCompose( kF.dA_m1, kF.dA_0  ),
  PreCompose( kF.dA_0,  kF.dA_1  ),
  PreCompose( kF.dA_1,  kF.dA_2  ),
  PreCompose( kF.dA_2,  kF.dA_3  ),

  # d^2 = 0  for B
  PreCompose( kF.dB_m6, kF.dB_m5 ),
  PreCompose( kF.dB_m5, kF.dB_m4 ),
  PreCompose( kF.dB_m4, kF.dB_m3 ),
  PreCompose( kF.dB_m3, kF.dB_m2 ),
  PreCompose( kF.dB_m2, kF.dB_m1 ),
  PreCompose( kF.dB_m1, kF.dB_0  ),
  PreCompose( kF.dB_0,  kF.dB_1  ),

  # d^2 = 0  for T
  PreCompose( kF.dT_m5, kF.dT_m4 ),
  PreCompose( kF.dT_m4, kF.dT_m3 ),
  PreCompose( kF.dT_m3, kF.dT_m2 ),
  PreCompose( kF.dT_m2, kF.dT_m1 ),
  PreCompose( kF.dT_m1, kF.dT_0  ),
  PreCompose( kF.dT_0,  kF.dT_1  ),
  PreCompose( kF.dT_1,  kF.dT_2  ),
  PreCompose( kF.dT_2,  kF.dT_3  ),

  # naturality of zeta : S -> A  (chain map condition d_A * zeta = zeta * d_S)
  PreCompose( kF.dS_m4,    kF.zeta_m3 ),                                    # dS_{-4} * zeta_{-3} = 0  (no zeta_{-4})
  PreCompose( kF.zeta_m3,  kF.dA_m3   ) - PreCompose( kF.dS_m3, kF.zeta_m2 ),
  PreCompose( kF.zeta_m2,  kF.dA_m2   ),                                    # zeta_{-2} * dA_{-2} = 0  (no zeta_{-1})

  # naturality of phi : A -> B
  PreCompose( kF.dA_m4,   kF.phi_m3  ),
  PreCompose( kF.phi_m3,  kF.dB_m3   ) - PreCompose( kF.dA_m3, kF.phi_m2 ),
  PreCompose( kF.phi_m2,  kF.dB_m2   ) - PreCompose( kF.dA_m2, kF.phi_m1 ),
  PreCompose( kF.phi_m1,  kF.dB_m1   ) - PreCompose( kF.dA_m1, kF.phi_0  ),
  PreCompose( kF.phi_0,   kF.dB_0    ),

  # naturality of tau : B -> T
  PreCompose( kF.dB_m5,   kF.tau_m4  ),
  PreCompose( kF.tau_m4,  kF.dT_m4   ) - PreCompose( kF.dB_m4, kF.tau_m3 ),
  PreCompose( kF.tau_m3,  kF.dT_m3   ) - PreCompose( kF.dB_m3, kF.tau_m2 ),
  PreCompose( kF.tau_m2,  kF.dT_m2   ) - PreCompose( kF.dB_m2, kF.tau_m1 ),
  PreCompose( kF.tau_m1,  kF.dT_m1   ) - PreCompose( kF.dB_m1, kF.tau_0  ),
  PreCompose( kF.tau_0,   kF.dT_0    ) - PreCompose( kF.dB_0,  kF.tau_1  ),
  PreCompose( kF.tau_1,   kF.dT_1    ),

  # zeta * phi = 0  (S -> A -> B is zero)
  PreCompose( kF.zeta_m3, kF.phi_m3 ),
  PreCompose( kF.zeta_m2, kF.phi_m2 ),

  # phi * tau = 0  (A -> B -> T is zero)
  PreCompose( kF.phi_m3, kF.tau_m3 ),
  PreCompose( kF.phi_m2, kF.tau_m2 ),
  PreCompose( kF.phi_m1, kF.tau_m1 ),
  PreCompose( kF.phi_0,  kF.tau_0  ) ];;

quo_cat := kF / rels;;

# ── 4. Compute data tables ───────────────────────────────────────────────────

Print( "Computing DataTablesOfLinearCategory ...\n" );
data_tables := DataTablesOfLinearCategory( quo_cat );;
Print( "Done.\n" );

# ── 5. Serialise the quiver as a constructor string ──────────────────────────

q_obj       := data_tables[2];;
obj_labels  := LabelsOfObjects( q_obj );;
mor_labels  := LabelsOfMorphisms( q_obj );;
src_indices := IndicesOfSources( q_obj );;
tgt_indices := IndicesOfTargets( q_obj );;

mor_strs := ListN( mor_labels, src_indices, tgt_indices,
              { l, s, t } -> Concatenation( l, ":", obj_labels[s], "->", obj_labels[t] ) );;

q_str := Concatenation(
           QuiverName( q_obj ), "(",
           JoinStringsWithSeparator( obj_labels, "," ),
           ")[",
           JoinStringsWithSeparator( mor_strs, "," ),
           "]" );;

# ── 6. Write the companion data file ─────────────────────────────────────────

tst_dir  := DirectoriesPackageLibrary( "ComplexesCategories", "tst" )[1];;
outfile  := Filename( tst_dir,
              "data_tables_for_test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g" );;

PrintTo( outfile,
  "# This file is auto-generated. Do not edit manually.\n",
  "# To regenerate, run (from the repository root):\n",
  "#   gap ComplexesCategories/tst/gen_test_kernel_and_cokernel_axioms_in_complexes_of_free_abelian_category.g\n",
  "#\n",
  "# Provides: k, data_tables\n\n" );

AppendTo( outfile, "k := HomalgFieldOfRationals();;\n" );
AppendTo( outfile, "data_tables := [ k,\n  \"", q_str, "\",\n  " );
AppendTo( outfile, String( data_tables[3] ) );
AppendTo( outfile, ",\n  " );
AppendTo( outfile, String( data_tables[4] ) );
AppendTo( outfile, ",\n  " );
AppendTo( outfile, String( data_tables[5] ) );
AppendTo( outfile, ",\n  " );
AppendTo( outfile, String( data_tables[6] ) );
AppendTo( outfile, " ];;\n" );

Print( "Written to ", outfile, "\n" );
QUIT;
