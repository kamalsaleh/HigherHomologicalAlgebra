# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
##  Chapter Functors
##
#############################################################################


####################################
#
#    Functors 
#
####################################

BindGlobal( "COKERNEL_OBJECT_AS_FUNCTOR", 
  function( cat, i, string )
    
    local functor, complex_cat, name, index;
    
    if string = "chains" then
      
      complex_cat := ChainComplexCategory( cat );
      
      index := -1;
      
      name := Concatenation( "Functor of cokernel object of the ", String( i ), "'th differential in ", Name( complex_cat ) );
    
    else
      
      complex_cat := CochainComplexCategory( cat );
      
      index := 1;
      
      name := Concatenation( "Functor of cokernel object of the ", String( i ), "'th differential in ", Name( complex_cat ) );
    
    fi;
    
    functor := CapFunctor( name, complex_cat, cat );
    
    AddObjectFunction( functor, 
    
    function( complex )
      
      return CokernelObject( complex^i );
    
    end );
    
    AddMorphismFunction( functor,
    
      function( new_source, map, new_range )
        
        return CokernelObjectFunctorial( Source( map )^i, map[ i + index ], Range( map )^i );
      
      end );
    
    return functor;
  
end );

BindGlobal( "KERNEL_OBJECT_AS_FUNCTOR", 
  function( cat, i, string )
    
    local functor, complex_cat, name, index;
    
    if string = "chains" then
      
      complex_cat := ChainComplexCategory( cat );
      
      name := Concatenation( "Functor of kernel object of the ", String( i ), "'th differential in ", Name( complex_cat ) );
    
    else
      
      complex_cat := CochainComplexCategory( cat );
      
      name := Concatenation( "Functor of kernel object of the ", String( i ), "'th differential in ", Name( complex_cat ) );
    
    fi;
    
    functor := CapFunctor( name, complex_cat, cat );
    
    AddObjectFunction( functor, 
    
      function( complex )
        
        return KernelObject( complex^i );
      
      end );
    
    AddMorphismFunction( functor,
      
      function( new_source, map, new_range )
        
        return KernelObjectFunctorial( Source( map )^i, map[ i ], Range( map )^i );
      
      end );
    
    return functor;
  
end );


# Homology and Cohomology functors

BindGlobal( "HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR", 
  function( cat, i, string )
    local functor, complex_cat, name;
      
    if string = "Homology" then
      
      complex_cat := ChainComplexCategory( cat );
      
      name := Concatenation( String( i ), "-th homology functor in ", Name( cat ) );
    
    else
      
      complex_cat := CochainComplexCategory( cat );
      
      name := Concatenation( String( i ), "-th cohomology functor in ", Name( cat ) );
      
    fi;
    
    functor := CapFunctor( name, complex_cat, cat );
    
    AddObjectFunction( functor, 
      
      function( complex )
        
        return HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX( complex, i );
      
      end );
    
    AddMorphismFunction( functor,
      
      function( new_source, map, new_range )
        
        return HOMOLOGY_OR_COHOMOLOGY_OF_COMPLEX_FUNCTORIAL( map, i );
        
      end );
    
    return functor;
  
end );


BindGlobal( "SHIFT_AS_FUNCTOR",
  function( complex_cat, n )
    local name, shift, morphism_constructor;
    
    if IsChainComplexCategory( complex_cat ) then 
      
      morphism_constructor := ChainMorphism;
    
    elif IsCochainComplexCategory( complex_cat ) then 
      
      morphism_constructor := CochainMorphism;
    
    else 
      
      Error( "The category should be either chain or cochain complexes category" );
    
    fi;
    
    if n = 0 then 
      
      return IdentityFunctor( complex_cat );
    
    elif n > 0 then
      
      name := Concatenation( "Shift (", String( n ), " times to the left) functor in ", Name( complex_cat ) );
    
    else
      
      name := Concatenation( "Shift (", String( -n ), " times to the right) functor in ", Name( complex_cat ) );
    
    fi;
    
    shift := CapFunctor( name, complex_cat, complex_cat );
    
    AddObjectFunction( shift, 
      
      function( complex )
        
        return ShiftLazy( complex, n );
      
      end );
    
    AddMorphismFunction( shift, 
      
      function( new_source, map, new_range )
        
        local morphisms;
        
        morphisms := Morphisms( map );
        
        morphisms := ApplyShift( morphisms, n );
        
        morphisms := morphism_constructor( new_source, new_range, morphisms );
        
        INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS( map, morphisms );
        
        return morphisms;
      
      end );
    
  return shift;
  
end );

BindGlobal( "UNSIGNED_SHIFT_AS_FUNCTOR",
  function( complex_cat, n )
    local name, shift, morphism_constructor;
    
    if IsChainComplexCategory( complex_cat ) then
      
      morphism_constructor := ChainMorphism;
    
    elif IsCochainComplexCategory( complex_cat ) then
      
      morphism_constructor := CochainMorphism;
    
    else 
      
      Error( "The category should be either chain or cochain complexes category" );
    
    fi;
   
    if n = 0 then 
      
      return IdentityFunctor( complex_cat );
    
    elif n>0 then 
      
      name := Concatenation( "Unsigned shift (", String( n ), " times to the left) functor in ", Name( complex_cat ) );
    
    else
      
      name := Concatenation( "Unsigned shift (", String( -n ), " times to the right) functor in ", Name( complex_cat ) );
    
    fi;
    
    shift := CapFunctor( name, complex_cat, complex_cat );
    
    AddObjectFunction( shift, 
      
      function( complex )
        
        return ShiftUnsignedLazy( complex, n );
      
      end );
    
    AddMorphismFunction( shift, 
      
      function( new_source, map, new_range )
        local morphisms;
        
        morphisms := Morphisms( map );
        
        morphisms := ApplyShift( morphisms, n );
        
        morphisms := morphism_constructor( new_source, new_range, morphisms );
        
        INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS( map, morphisms );
        
        return morphisms;
        
      end );
    
    return shift;
  
end );

BindGlobal( "CHAIN_TO_COCHAIN_OR_COCHAIN_TO_CHAIN_FUNCTOR",
  function( cat, string )
    local chain_complexes, cochain_complexes, complex_constructor, name, functor, morphism_constructor;
    
    chain_complexes := ChainComplexCategory( cat );
    
    cochain_complexes := CochainComplexCategory( cat );
    
    if string = "chain_to_cochain" then
      
      name := Concatenation("Chain to Cochain complex functor over ", Name( cat ) );
      
      functor := CapFunctor( name, chain_complexes, cochain_complexes );
      
      complex_constructor := CochainComplex;
      
      morphism_constructor := CochainMorphism;
      
    elif string = "cochain_to_chain" then 
      
      name := Concatenation("Cochain to chain complex functor over ", Name( cat ) );
      
      functor := CapFunctor( name, cochain_complexes, chain_complexes );
      
      complex_constructor := ChainComplex;
      
      morphism_constructor := ChainMorphism;
      
    else 
      
      Error( "string should be either chain_to_cochain or cochain_to_chain" );
    
    fi;
    
    AddObjectFunction( functor,
      function( C )
        local diffs, complex;
        
        diffs := Reflection( Differentials( C ) );
        
        complex := complex_constructor( cat, diffs );
        
        AddToToDoList( ToDoListEntryForEqualAttributes( C, "IsZeroForObjects", complex, "IsZeroForObjects" ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ],
          
          function( )
            
            if not HasFAL_BOUND( complex ) then
              
              SetLowerBound( complex, -FAU_BOUND( C ) );
            
            fi;
            
          end ) );
        
        AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAU_BOUND", true ] ],
          
          function( )
            
            if not HasFAL_BOUND( C ) then
              
              SetLowerBound( C, -FAU_BOUND( complex ) );
            
            fi;
            
          end ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ],
          
          function( )
            
            if not HasFAU_BOUND( complex ) then
              
               SetUpperBound( complex, -FAL_BOUND( C ) );
               
            fi;
          
          end ) );
        
        AddToToDoList( ToDoListEntry( [ [ complex, "HAS_FAL_BOUND", true ] ],
          
          function( )
            
            if not HasFAU_BOUND( C ) then
              
              SetUpperBound( C, -FAL_BOUND( complex ) );
            
            fi;
          
          end ) );
       
      return complex;
      
    end );
    
   AddMorphismFunction( functor, 
     function( new_source, map, new_range )
       local morphisms;
       
       morphisms := Reflection( Morphisms( map ) );
       
       morphisms := morphism_constructor( new_source, new_range, morphisms );
       
       INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS( map, morphisms );
       
       return morphisms;
       
     end );
   
   return functor;
   
end );

##
InstallMethod( KernelObjectFunctor, 
               [ IsChainOrCochainComplexCategory, IsCapCategory, IsInt ],
  function( complex_cat, cat, i )
    
    if IsChainComplexCategory( complex_cat ) then
      
      return KERNEL_OBJECT_AS_FUNCTOR( cat, i, "chains" );
      
    elif IsCochainComplexCategory( complex_cat ) then
      
      return KERNEL_OBJECT_AS_FUNCTOR( cat, i, "cochains" );
      
    else
      
      Error( "The input is wrong" );
      
    fi;
  
end );

##
InstallMethod( CokernelObjectFunctor, 
      [ IsChainOrCochainComplexCategory, IsCapCategory, IsInt ],
  function( complex_cat, cat, i )
    
    if IsChainComplexCategory( complex_cat ) then
      
      return COKERNEL_OBJECT_AS_FUNCTOR( cat, i, "chains" );
    
    elif IsCochainComplexCategory( complex_cat ) then
      
      return COKERNEL_OBJECT_AS_FUNCTOR( cat, i, "cochains" );
      
    else
      
      Error( "The input is wrong" );
    
    fi;
  
end );

##
InstallOtherMethod( HomologyFunctorOp, 
               [ IsChainComplexCategory, IsInt ],
  function( complex_cat, i )
    local cat;
    
    cat := UnderlyingCategory( complex_cat );
    
    return HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR( cat, i, "Homology" );
  
end );

##
InstallOtherMethod( CohomologyFunctorOp, 
               [ IsCochainComplexCategory, IsInt ],
  function( complex_cat, i )
    local cat;
    
    cat := UnderlyingCategory( complex_cat );
    
    return HOMOLOGY_OR_COHOMOLOGY_AS_FUNCTOR( cat, i, "Cohomology" );
    
end );

##
InstallMethod( ShiftFunctorOp, 
                [ IsChainOrCochainComplexCategory, IsInt ], 
  function( complex_cat, n )
    
    return SHIFT_AS_FUNCTOR( complex_cat, n );
  
end );

##
InstallMethod( UnsignedShiftFunctorOp,
                [ IsChainOrCochainComplexCategory, IsInt ],
  function( complex_cat, n )
    
    return UNSIGNED_SHIFT_AS_FUNCTOR( complex_cat, n );
  
end );

##
InstallMethod( ChainToCochainComplexFunctor, 
               [ IsChainComplexCategory, IsCochainComplexCategory ], 
  function( cat1, cat2  )
    
    return CHAIN_TO_COCHAIN_OR_COCHAIN_TO_CHAIN_FUNCTOR( UnderlyingCategory( cat1 ), "chain_to_cochain" );
    
end );

##
InstallMethod( CochainToChainComplexFunctor, 
               [ IsCochainComplexCategory, IsChainComplexCategory ], 
  function( cat1, cat2 )
    
    return CHAIN_TO_COCHAIN_OR_COCHAIN_TO_CHAIN_FUNCTOR( UnderlyingCategory( cat1 ), "cochain_to_chain" );
    
end );

##
InstallMethod( ExtendFunctorToChainComplexCategories,
               [ IsCapFunctor ],
  function( F )
    local S, T, functor, name, r;
    
    S := ChainComplexCategory( SourceOfFunctor( F ) );
    
    T := ChainComplexCategory( RangeOfFunctor( F ) );
    
    name := Concatenation(
                "Extension of ( ",
                Name( F ),
                " ) to complex categories"
            );
 
    functor := CapFunctor( name, S, T );
    
    AddObjectFunction( functor,
      function( C )
        local diffs, functor_C;
        
        diffs := ApplyMap( Differentials( C ), d -> ApplyFunctor( F, d ) );
        
        functor_C := ChainComplex( RangeOfFunctor( F ), diffs );
        
        TODO_LIST_TO_PUSH_BOUNDS( C, functor_C );
        
        #AddToToDoList( ToDoListEntry( [ [ C, "IsZeroForObjects", true ] ],
        #  function( )
        #    
        #    if not HasIsZeroForObjects( functor_C ) then 
        #      
        #      SetIsZeroForObjects( functor_C, true );
        #    
        #    fi;
        #  
        #  end ) );
        
        return functor_C;
        
      end );
    
    AddMorphismFunction( functor, 
      function( new_source, phi, new_range ) 
        local morphisms, functor_phi;
        
        morphisms := ApplyMap( Morphisms( phi ),
          function( psi )
            
            return ApplyFunctor( F, psi );
          
          end );
        
        functor_phi := ChainMorphism( new_source, new_range, morphisms );
        
        TODO_LIST_TO_PUSH_BOUNDS( phi, functor_phi );
        
        #AddToToDoList( ToDoListEntry( [ [ phi, "IsZeroForMorphisms", true ] ],
        #  
        #  function( )
        #    
        #    if not HasIsZeroForMorphisms( functor_phi ) then
        #      
        #      SetIsZeroForMorphisms( functor_phi, true );
        #    
        #    fi; 
        #  
        #  end ) );
        
        return functor_phi;
        
        end );
      
    return functor;
    
end );

InstallMethod( ExtendFunctorToCochainComplexCategories,
               [ IsCapFunctor ],
  function( F )
    local S, T, functor, name, r;
    
    S := CochainComplexCategory( SourceOfFunctor( F ) );
    
    T := CochainComplexCategory( RangeOfFunctor( F ) );
    
    r := RandomTextColor( Name( F ) );
    
    name := Concatenation( r[ 1 ], "The extension functor of ", r[ 2 ], Name( F ), r[ 1 ], " to cochain complex categories", r[ 2 ] );
    
    functor := CapFunctor( name, S, T );
    
    AddObjectFunction( functor,
      function( C )
        local diffs, functor_C;
        
        diffs := ApplyMap( Differentials( C ),
          
          function( d )
            
            return ApplyFunctor( F, d );
          
          end );
        
        functor_C := CochainComplex( RangeOfFunctor( F ), diffs );
        
        TODO_LIST_TO_PUSH_BOUNDS( C, functor_C );
        
        AddToToDoList( ToDoListEntry( [ [ C, "IsZeroForObjects", true ] ],
          function( )
            
            if not HasIsZeroForObjects( functor_C ) then
              
              SetIsZeroForObjects( functor_C, true );
            
            fi;
          
          end ) );
        
        return functor_C;
      
      end );
    
    AddMorphismFunction( functor,
      function( new_source, phi, new_range ) 
        local morphisms, functor_phi;
        
        morphisms := ApplyMap( Morphisms( phi ),
          function( psi )
            
            return ApplyFunctor( F, psi );
          
          end );
        
        functor_phi := CochainMorphism( new_source, new_range, morphisms );
        
        TODO_LIST_TO_PUSH_BOUNDS( phi, functor_phi );
        
        AddToToDoList( ToDoListEntry( [ [ phi, "IsZeroForMorphisms", true ] ],
          
          function( )
            
            if not HasIsZeroForMorphisms( functor_phi ) then
              
              SetIsZeroForMorphisms( functor_phi, true );
            
            fi;
          
          end ) );
        
        return functor_phi;
    
    end );
    
    return functor;
  
end );

##
InstallMethod( ChainCategoryToCochainCategoryOfOppositeCategory,
      [ IsCapCategory ],
  function( cat )
    local chains, cochains, functor;
    
    chains := ChainComplexCategory( cat );
    
    cochains := CochainComplexCategory( Opposite( cat ) );
    
    functor := CapFunctor( "Bla Bla", chains, cochains );
    
    AddObjectFunction( functor,
      function( C )
        local inf_list;
        
        inf_list := ApplyMap( Differentials( C ), Opposite );
        
        inf_list := ApplyShift( inf_list, 1 );
        
        return CochainComplex( Opposite( cat ), inf_list );
        
      end );
    
    AddMorphismFunction( functor,
      function( obj1, phi, obj2 )
        local inf_list;
        
        inf_list := ApplyMap( Morphisms( phi ), Opposite );
        
        return CochainMorphism( obj1, obj2, inf_list );
        
      end );
    
    return functor;
    
end );

##
InstallMethod( CochainCategoryToChainCategoryOfOppositeCategory,
                [ IsCapCategory ],
  function( cat )
    local chains, cochains, functor;
    
    cochains := CochainComplexCategory( cat );
    
    chains := ChainComplexCategory( Opposite( cat ) );
    
    functor := CapFunctor( "Bla Bla", cochains, chains );
    
    AddObjectFunction( functor,
      function( C )
        local inf_list;
        
        inf_list := ApplyMap( Differentials( C ), Opposite );
        
        inf_list := ApplyShift( inf_list, -1 );
        
        return ChainComplex( Opposite( cat ), inf_list );
        
      end );
    
    AddMorphismFunction( functor,
      function( obj1, phi, obj2 )
        local inf_list;
        
        inf_list := ApplyMap( Morphisms( phi ), Opposite );
        
        return ChainMorphism( obj1, obj2, inf_list );
        
      end );
    
    return functor;
    
end );

InstallMethod( BrutalTruncationAboveFunctorOp,
        [ IsCapCategory and IsCochainComplexCategory, IsInt ],
    function( cochains, n )
      local name, F;
      
      name := Concatenation( "Functor of brutal truncation from above (C -> C^<= ", String( n ), ") in ", Name( cochains ) );
      
      F := CapFunctor( name, cochains, cochains );
      
      AddObjectFunction( F,
        function( C )
        
          return BrutalTruncationAbove( C, n );
          
        end );
      
      AddMorphismFunction( F,
        function( new_source, phi, new_range )
          local morphisms;
          
          morphisms := AsZFunction( 
            function( i ) 
              
              if i <= n then 
                
                return phi[ i ];
              
              else
                
                return ZeroMorphism( new_source[ i ], new_range[ i ] );
              
              fi;
            
            end );
      
      return CochainMorphism( new_source, new_range, morphisms );
    
    end );
    
    return F;
end );

InstallMethod( BrutalTruncationBelowFunctorOp,
        [ IsCapCategory and IsCochainComplexCategory, IsInt ],
    function( cochains, n )
      local name, F;
      
      name := Concatenation( "Functor of brutal truncation from below (C -> C^> ", String( n ), ") in ", Name( cochains ) );
      F := CapFunctor( name, cochains, cochains );
      AddObjectFunction( F,
      function( C )
        
        return BrutalTruncationBelow( C, n );
        
      end );
      
      AddMorphismFunction( F,
        
        function( new_source, phi, new_range )
          local morphisms;
          
          morphisms := AsZFunction(
            function( i ) 
              
              if i > n then 
                
                return phi[ i ];
              
              else
                
                return ZeroMorphism( new_source[ i ], new_range[ i ] );
              
              fi;
            
            end );
          
      return CochainMorphism( new_source, new_range, morphisms );
      
      end );
      
    return F;
    
end );

InstallMethod( BrutalTruncationAboveFunctorOp,
        [ IsCapCategory and IsChainComplexCategory, IsInt ],
  function( chains, n )
    local name, F;
    
    name := Concatenation( "Functor of brutal truncation from above (C -> C_< ", String( n ), ") in ", Name( chains ) );
    
    F := CapFunctor( name, chains, chains );
    
    AddObjectFunction( F,
      
      function( C )
      
        return BrutalTruncationAbove( C, n );
        
      end );
    
    AddMorphismFunction( F,
      function( new_source, phi, new_range )
        local morphisms;
        
        morphisms := AsZFunction( 
        
          function( i ) 
          
            if i < n then 
              
              return phi[ i ];
            
            else
              
              return ZeroMorphism( new_source[ i ], new_range[ i ] );
            
            fi;
          
          end );
        
    return ChainMorphism( new_source, new_range, morphisms );
    
    end );
    
    return F;
  
end );

InstallMethod( BrutalTruncationBelowFunctorOp,
        [ IsCapCategory and IsChainComplexCategory, IsInt ],
  function( chains, n )
    local name, F;
    
    name := Concatenation( "Functor of brutal truncation from below (C -> C_>= ", String( n ), ") in ", Name( chains ) );
    
    F := CapFunctor( name, chains, chains );
    
    AddObjectFunction( F,
    
      function( C )
        return BrutalTruncationBelow( C, n );
      end );
    
    AddMorphismFunction( F,
      function( new_source, phi, new_range )
        local morphisms;
        
        morphisms := AsZFunction( 
                            
          function( i ) 
            
            if i >= n then 
              
              return phi[ i ];
            
            else
              
              return ZeroMorphism( new_source[ i ], new_range[ i ] );
            
            fi;
          
          end );
        
      return ChainMorphism( new_source, new_range, morphisms );
      
      end );
    
    return F;
    
end );

InstallMethod( ExtendFunctorFromProductCategoryToChainComplexCategories,
      [ IsCapFunctor ],
  function( F )
    local source, cat_1, cat_2, range, ch_range, ch_cat_1, ch_cat_2, ch_cat_1_ch_cat_2, name, U; 
    
    source := SourceOfFunctor( F );
    
    if not HasComponents( source ) then
      
      Error( "The source of the category should be a product category!\n" );
      
    fi;
    
    if Length( Components( source ) ) <> 2 then
      
      Error( "The source should be product of two categories!\n" );
      
    fi;
    
    cat_1 := Components( source )[ 1 ];
    
    cat_2 := Components( source )[ 2 ];
    
    range := RangeOfFunctor( F );
    
    ch_cat_1 := ChainComplexCategory( cat_1 );
    
    ch_cat_2 := ChainComplexCategory( cat_2 );
    
    ch_range := ChainComplexCategory( range );
    
    ch_cat_1_ch_cat_2 := Product( ch_cat_1, ch_cat_2 );
    
    name := "Extension of a functor from product category to chain complexes";
    
    U := CapFunctor( name, ch_cat_1_ch_cat_2, ch_range );
    
    AddObjectFunction( U,
      function( C_x_D )
        local C, D, H, V, d;
        
        C := Components( C_x_D )[ 1 ];
        
        D := Components( C_x_D )[ 2 ];
        
        if not ( HasActiveUpperBound( C ) and HasActiveUpperBound( D ) ) then
          
          if not ( HasActiveLowerBound( C ) and HasActiveLowerBound( D ) ) then
            
            if not ( HasActiveLowerBound( C ) and HasActiveUpperBound( C ) ) then
              
              if not ( HasActiveLowerBound( D ) and HasActiveUpperBound( D ) ) then
                
                Error( "to be written");
              
              fi;
            
            fi;
          
          fi;
        
        fi;
        
        H := function( i, j )
          
          return ApplyFunctor( F, [ C^i, IdentityMorphism( D[ j ] ) ] / source );
          
        end;
        
        V := function( i, j )
          
          if i mod 2 = 0 then
          
            return ApplyFunctor( F, [ IdentityMorphism( C[ i ] ), D^j ] / source );
            
          else
          
            return AdditiveInverse( ApplyFunctor( F, [ IdentityMorphism( C[ i ] ), D^j ] / source ) );
          
          fi;
        
        end;
        
        d := DoubleChainComplex( range, H, V );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAU_BOUND", true ] ],
          
          function( )
            
            SetRightBound( d, ActiveUpperBound( C ) );
            
        end ) );
        
        AddToToDoList( ToDoListEntry( [ [ C, "HAS_FAL_BOUND", true ] ],
          
          function( )
          
            SetLeftBound( d, ActiveLowerBound( C ) );
            
        end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAU_BOUND", true ] ],
        
          function( )
          
            SetAboveBound( d, ActiveUpperBound( D ) );
            
        end ) );
        
        AddToToDoList( ToDoListEntry( [ [ D, "HAS_FAL_BOUND", true ] ],
        
          function( )
          
            SetBelowBound( d, ActiveLowerBound( D ) );
            
        end ) );
        
        return TotalComplex( d );
        
      end );
      
    AddMorphismFunction( U,
      
      function( S, phi_x_psi, T )
        local phi, psi, ss, tt, l;
        
        phi := Components( phi_x_psi )[ 1 ];
        
        psi := Components( phi_x_psi )[ 2 ];
        
        ss := S!.UnderlyingDoubleComplex;
        
        tt := T!.UnderlyingDoubleComplex;
        
        l := AsZFunction(
          
          function( m )
            local ind_s, ind_t, morphisms, obj;
            
            # this is important to write the used indices.
            obj := ObjectAt( S, m );
            
            obj := ObjectAt( T, m );
            
            ind_s := ss!.IndicesOfTotalComplex.( String( m ) );
            
            ind_t := tt!.IndicesOfTotalComplex.( String( m ) );
            
            morphisms := List( [ ind_s[ 1 ] .. ind_s[ 2 ] ],
              
              function( i )
                
                return List( [ ind_t[ 1 ] .. ind_t[ 2 ] ], 
                  
                  function( j )
                    
                    if i = j then
                      
                      return ApplyFunctor( F, [ phi[ i ], psi[ m - i ] ] / source );
                    
                    else
                      
                      return ZeroMorphism( ObjectAt( ss, i, m - i), ObjectAt( tt, j, m - j ) );
                    
                    fi;
                    
                    end );
              
              end );
            
            return MorphismBetweenDirectSums( morphisms );
            
            end );
        
        return ChainMorphism( S, T, l );
      
      end );
      
      return U;
    
end );

##
InstallMethod( StalkChainFunctorOp,
          [ IsCapCategory, IsInt ],
  function( cat, n )
    local complexes, name, F;
    
    complexes := ChainComplexCategory( cat );
    
    name := Concatenation( "Stalk chain functor from ", Name( cat ), " to ", Name( complexes ) );
    
    F := CapFunctor( name, cat, complexes );
    
    AddObjectFunction( F,
      function( c )
        
        return StalkChainComplex( c, n );
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        
        return StalkChainMorphism( alpha, n );
        
    end );
    
    return F;
    
end );

##
InstallMethod( StalkCochainFunctorOp,
          [ IsCapCategory, IsInt ],
  function( cat, n )
    local complexes, name, F;
    
    complexes := CochainComplexCategory( cat );
    
    name := Concatenation( "Stalk cochain functor from ", Name( cat ), " to ", Name( complexes ) );
    
    F := CapFunctor( name, cat, complexes );
    
    AddObjectFunction( F,
      function( c )
        
        return StalkCochainComplex( c, n );
        
    end );
    
    AddMorphismFunction( F,
      function( s, alpha, r )
        
        return StalkCochainMorphism( alpha, n );
        
    end );
    
    return F;
    
end );

##
InstallMethod( MinusOneFunctor,
          [ IsChainOrCochainComplexCategory ],
  function( complexes )
    local morphism_constructor, name, F;
    
    if IsChainComplexCategory( complexes ) then
      
      morphism_constructor := ChainMorphism;
      
    else
      
      morphism_constructor := CochainMorphism;
      
    fi;
    
    name := "⊝ automorphism";
    
    F := CapFunctor( name, complexes, complexes );
    
    AddObjectFunction( F, C -> -1 * C );
    
    AddMorphismFunction( F, { s, phi, r } -> morphism_constructor( s, r, Morphisms( phi ) ) );
    
    return F;
    
end );

##
InstallMethod( LeftDerivedFunctorAttrOp,
          [ IsCapFunctor, IsInt ],
  function( F, n )
    local s_cat, r_cat, name, Ln_F, ChF, Hn, ChF_Hn;
    
    if n < 0 then
      
      Error( "The second argument should be a positive integer!\n" );
      
    fi;
    
    s_cat := SourceOfFunctor( F );
    
    if not IsAbelianCategoryWithComputableEnoughProjectives( s_cat ) then
      
      Error( "The source category should be abelian with computable enough projectives!\n" );
      
    fi;
    
    r_cat := RangeOfFunctor( F );
    
    name := Concatenation( String( n ), "- left derived functor of ", Name( F ) );
    
    Ln_F := CapFunctor( name, s_cat, r_cat );
    
    ChF := ExtendFunctorToChainComplexCategories( F );
    
    Hn := HomologyFunctor( RangeOfFunctor( ChF ), n );
    
    ChF_Hn := PreCompose( ChF, Hn );
    
    AddObjectFunction( Ln_F,
      a -> ChF_Hn( ProjectiveChainResolution( a ) )
    );
    
    AddMorphismFunction( Ln_F,
      { s, alpha, r } -> ChF_Hn( MorphismBetweenProjectiveChainResolutions( alpha ) )
    );
    
    return Ln_F;
    
end );

##
InstallMethod( LeftDerivedFunctor,
          [ IsCapFunctor, IsInt ],
  LeftDerivedFunctorAttr
);

##
InstallMethod( RightDerivedFunctorAttrOp,
          [ IsCapFunctor, IsInt ],
  function( F, n )
    local s_cat, r_cat, name, Rn_F, ChF, Hn, ChF_Hn;
    
    if n < 0 then
      
      Error( "The second argument should be a positive integer!\n" );
      
    fi;
    
    s_cat := SourceOfFunctor( F );
    
    if not IsAbelianCategoryWithComputableEnoughInjectives( s_cat ) then
      
      Error( "The source category should be abelian with computable enough injectives!\n" );
      
    fi;
    
    r_cat := RangeOfFunctor( F );
    
    name := Concatenation( String( n ), "- right derived functor of ", Name( F ) );
    
    Rn_F := CapFunctor( name, s_cat, r_cat );
    
    ChF := ExtendFunctorToChainComplexCategories( F );
    
    Hn := HomologyFunctor( RangeOfFunctor( ChF ), -n );
    
    ChF_Hn := PreCompose( ChF, Hn );
    
    AddObjectFunction( Rn_F,
      a -> ChF_Hn( InjectiveChainResolution( a ) )
    );
    
    AddMorphismFunction( Rn_F,
      { s, alpha, r } -> ChF_Hn( MorphismBetweenInjectiveChainResolutions( alpha ) )
    );
    
    return Rn_F;
    
end );

##
InstallMethod( RightDerivedFunctor,
          [ IsCapFunctor, IsInt ],
  RightDerivedFunctorAttr
);

##
InstallMethod( ExtendFunctorMethodToComplexCategories,
          [ IsDenseList ],
          
  function( E )
    
    ExtendFunctorMethod(
      E,
      IsChainComplexCategory,
      UnderlyingCategory,
      ExtendFunctorToChainComplexCategories,
      "ExtendFunctorToChainComplexCategories"
    );
    
    ExtendFunctorMethod(
      E,
      IsCochainComplexCategory,
      UnderlyingCategory,
      ExtendFunctorToCochainComplexCategories,
      "ExtendFunctorToCochainComplexCategories"
    );
    
end );
