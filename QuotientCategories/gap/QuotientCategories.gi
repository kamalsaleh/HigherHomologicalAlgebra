# SPDX-License-Identifier: GPL-2.0-or-later
# QuotientCategories: Quotient categories of CAP categories by two-sided ideals
#
# Implementations
#

##
InstallValue( CAP_INTERNAL_METHOD_NAME_LIST_FOR_QUOTIENT_CATEGORY,
  [
   "AdditionForMorphisms",
   "AdditiveInverseForMorphisms",
   "IdentityMorphism",
   "IsEndomorphism",
   "IsEqualForMorphisms",
   "IsEqualForObjects",
   "IsEqualForCacheForMorphisms",
   "IsEqualForCacheForObjects",
   "IsEqualToIdentityMorphism",
   "IsEqualToZeroMorphism",
   #"MultiplyWithElementOfCommutativeRingForMorphisms",
   "PostCompose",
   "PreCompose",
   "SubtractionForMorphisms",
   "ZeroMorphism",
   "IsWellDefinedForObjects",
   "IsWellDefinedForMorphisms",
   
   # Additive operations
   
   "ComponentOfMorphismFromDirectSum",
   "ComponentOfMorphismIntoDirectSum",
   "DirectSum",
   "DirectSumCodiagonalDifference",
   "DirectSumDiagonalDifference",
   "DirectSumFunctorialWithGivenDirectSums",
   "DirectSumProjectionInPushout",
   "InjectionOfCofactorOfDirectSum",
   "InjectionOfCofactorOfDirectSumWithGivenDirectSum",
   "IsomorphismFromCoproductToDirectSum",
   "IsomorphismFromDirectProductToDirectSum",
   "IsomorphismFromDirectSumToCoproduct",
   "IsomorphismFromDirectSumToDirectProduct",
   "MorphismBetweenDirectSumsWithGivenDirectSums",
   "ProjectionInFactorOfDirectSum",
   "ProjectionInFactorOfDirectSumWithGivenDirectSum",
   "UniversalMorphismFromDirectSum",
   "UniversalMorphismFromDirectSumWithGivenDirectSum",
   "UniversalMorphismIntoDirectSum",
   "UniversalMorphismIntoDirectSumWithGivenDirectSum",
   "UniversalMorphismFromZeroObject",
   "UniversalMorphismFromZeroObjectWithGivenZeroObject",
   "UniversalMorphismIntoZeroObject",
   "UniversalMorphismIntoZeroObjectWithGivenZeroObject",
   "ZeroObject",
   "ZeroObjectFunctorial",
   ] );

##
InstallMethod( QuotientCategory,
          [ IsRecord ],
  
  function( record )
    local congruence_function, cat, name, category_filter, category_object_filter, category_morphism_filter,
          object_constructor, object_datum, morphism_constructor, morphism_datum,
          create_func_bool, create_func_object, create_func_morphism,
          list_of_operations_to_install, commutative_ring,
          properties, supports_empty_limits, quotient_cat;
    
    if not IsBound( record.congruence_function ) then
      Error( "the record passed to the category constructor 'QuotientCategory' is missing a component 'congruence_function'!\n" );
    fi;
    
    if not IsBound( record.nr_arguments_of_congruence_function ) then
       Error( "the record passed to the category constructor 'QuotientCategory' is missing a component 'nr_arguments_of_congruence_function'!\n" );
    fi;
    
    if record.nr_arguments_of_congruence_function = 1 then
      
      record.nr_arguments_of_congruence_function := 2;
      
      congruence_function := record.congruence_function;
      
      record.congruence_function := { alpha, beta } -> congruence_function( SubtractionForMorphisms( alpha, beta ) );
      
      return QuotientCategory( record );
      
    fi;
    
    cat := record.underlying_category;
    
    if IsBound( record.name ) then
      name := record.name;
    else
      name := Concatenation( "Quotient category( ", Name( cat ), " ) defined by the congruence function ", NameFunction( record.congruence_function ) );
    fi;
    
    if IsBound( record.category_filter ) then
      category_filter := record.category_filter;
    else
      category_filter := IsQuotientCapCategory;
    fi;
    
    if IsBound( record.category_object_filter ) then
      category_object_filter := record.category_object_filter;
    else
      category_object_filter := IsQuotientCapCategoryObject;
    fi;
   
    if IsBound( record.category_morphism_filter ) then
      category_morphism_filter := record.category_morphism_filter;
    else
      category_morphism_filter := IsQuotientCapCategoryMorphism;
    fi;
    
    object_constructor := { quotient_cat, datum } -> CreateCapCategoryObjectWithAttributes( quotient_cat, UnderlyingCell, datum );
    
    object_datum := { quotient_cat, o } -> UnderlyingCell( o );
    
    morphism_constructor := { quotient_cat, S, datum, R }  -> CreateCapCategoryMorphismWithAttributes( quotient_cat, S, R, UnderlyingCell, datum );
    
    morphism_datum := { quotient_cat, m } -> UnderlyingCell( m );
    
    list_of_operations_to_install := Intersection( ListInstalledOperationsOfCategory( cat ), CAP_INTERNAL_METHOD_NAME_LIST_FOR_QUOTIENT_CATEGORY );
    
    if HasCommutativeRingOfLinearCategory( cat ) then
        commutative_ring := CommutativeRingOfLinearCategory( cat );
    else
        commutative_ring := fail;
    fi;
    
    properties := [ "IsAbCategory",
                    "IsLinearCategoryOverCommutativeRing",
                    "IsAdditiveCategory",
                    ];
    
    properties := Intersection( ListKnownCategoricalProperties( cat ), properties );
    
    create_func_bool :=
          function ( name, quotient_cat )
            return
              """
              function( input_arguments... )
                
                return CallFuncList( operation_name, List( NTuple( number_of_arguments, input_arguments... ){[2 .. number_of_arguments]}, UnderlyingCell ) );
                
              end
              """;
          end;
    
    create_func_object :=
          function ( name, quotient_cat )
            
            if name in [ "TerminalObject", "InitialObject", "ZeroObject" ] then
              return
                """
                function( input_arguments... )
                  
                  return ObjectConstructor( cat, operation_name( UnderlyingCategory( cat ) ) );
                  
                end
                """;
            
            elif name in [ "DirectProduct", "Coproduct", "DirectSum" ] then
              
              return ## a constructor for universal objects: DirectSum
                """
                function ( input_arguments... )
                  local i_arg;
                  
                  i_arg := NTuple( number_of_arguments, input_arguments... );
                  
                  return ObjectConstructor( cat, operation_name( UnderlyingCategory( cat ), List( i_arg[2], UnderlyingCell ) ) );
                  
                end
                """;
            
            else
              
              Print( "WARNING: the category constructor 'QuotientCategory' cannot deal with ", name, " yet\n" );
              return "ReturnFail";
            
            fi;
          
          end;
    
    create_func_morphism :=
      function ( name, cat )
        local info;
        
        info := CAP_INTERNAL_METHOD_NAME_RECORD.(name);
        
        return
          ReplacedStringViaRecord(
          """
          function ( input_arguments... )
            local underlying_cat, i_arg;
            
            underlying_cat := UnderlyingCategory( cat );
            
            i_arg := NTuple( number_of_arguments, input_arguments... );
            
            return MorphismConstructor( cat, top_source, operation_name( underlying_cat, sequence_of_arguments... ), top_range );
            
        end
        """,
        rec( sequence_of_arguments :=
             List( [ 2 .. Length( info.filter_list ) ],
                   function( j )
                     local type;
                     
                     type := info.filter_list[j];
                     
                     if type = IsInt then
                         return Concatenation( "i_arg[", String( j ), "]" );
                     elif type in [ "object", "morphism" ] then
                         return Concatenation( "UnderlyingCell( i_arg[", String( j ), "] )" );
                     elif type in [ "list_of_objects", "list_of_morphisms" ] then
                         return Concatenation( "List( i_arg[", String( j ), "], UnderlyingCell )" );
                     else
                         Error( "can only deal with IsInt, \"object\", \"morphism\", \"list_of_objects\", \"list_of_morphisms\"" );
                     fi;
                     
                  end ) ) );
    
    end;
    
    if IsBound( cat!.supports_empty_limits ) then
        supports_empty_limits := cat!.supports_empty_limits;
    else
        supports_empty_limits := false;
    fi;
    
    quotient_cat := CategoryConstructor(
                        rec( name := name,
                             category_filter := category_filter,
                             category_object_filter := category_object_filter,
                             category_morphism_filter := category_morphism_filter,
                             commutative_ring_of_linear_category := commutative_ring,
                             properties := properties,
                             object_constructor := object_constructor,
                             object_datum := object_datum,
                             morphism_constructor := morphism_constructor,
                             morphism_datum := morphism_datum,
                             underlying_category_getter_string := "UnderlyingCategory",
                             list_of_operations_to_install := list_of_operations_to_install,
                             supports_empty_limits := supports_empty_limits,
                             create_func_bool := create_func_bool,
                             create_func_object := create_func_object,
                             create_func_morphism := create_func_morphism ) );
    
    SetUnderlyingCategory( quotient_cat, cat );
    SetQuotientCategoryCongruenceFunction( quotient_cat, record.congruence_function );
    
    AddIsCongruentForMorphisms( quotient_cat,
      function( quotient_cat, phi, psi )
      
        return QuotientCategoryCongruenceFunction( quotient_cat )( UnderlyingCell( phi ), UnderlyingCell( psi ) );
        
    end );
    
    if CanCompute( cat, "MultiplyWithElementOfCommutativeRingForMorphisms" ) then
        
        ##
        AddMultiplyWithElementOfCommutativeRingForMorphisms( quotient_cat,
          function( quotient_cat, r, phi )
            
            return MorphismConstructor( quotient_cat, MultiplyWithElementOfCommutativeRingForMorphisms( UnderlyingCategory( quotient_cat ), r, UnderlyingCell( phi ) ) );
            
        end );
    
    fi;
    
    ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_QUOTIENT_CATEGORY( quotient_cat );
    
    Finalize( quotient_cat );
    
    return quotient_cat;
    
end );


InstallGlobalFunction( ADD_FUNCTIONS_OF_RANDOM_METHODS_TO_QUOTIENT_CATEGORY,
  function( quotient_cat )
    local cat;
    
    cat := UnderlyingCategory( quotient_cat );
    
    if CanCompute( cat, "RandomObjectByInteger" ) then
        
        AddRandomObjectByInteger( quotient_cat,
            function( quotient_cat, i )
              return ObjectConstructor( quotient_cat, RandomObjectByInteger( UnderlyingCategory( quotient_cat ), i ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedSourceAndRangeByInteger" ) then
        
        AddRandomMorphismWithFixedSourceAndRangeByInteger( quotient_cat,
            function( quotient_cat, S, R, i )
                local alpha;
                alpha := RandomMorphismWithFixedSourceAndRangeByInteger( UnderlyingCategory( quotient_cat ), UnderlyingCell( S ), UnderlyingCell( R ), i );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedSourceByInteger" ) then
        
        AddRandomMorphismWithFixedSourceByInteger( quotient_cat,
            function( quotient_cat, S, i )
                local alpha;
                alpha := RandomMorphismWithFixedSourceByInteger( UnderlyingCategory( quotient_cat ), UnderlyingCell( S ), i );
                return MorphismConstructor( quotient_cat,  S, alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedRangeByInteger" ) then
        
        AddRandomMorphismWithFixedRangeByInteger( quotient_cat,
            function( quotient_cat, R, i )
                local alpha;
                alpha := RandomMorphismWithFixedRangeByInteger( UnderlyingCategory( quotient_cat ), UnderlyingCell( R ), i );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, R );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismByInteger" ) then
        
        AddRandomMorphismByInteger( quotient_cat,
            function( quotient_cat, i )
                local alpha;
                alpha := RandomMorphismByInteger( UnderlyingCategory( quotient_cat ), i );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
    fi;
    
    if CanCompute( cat, "RandomObjectByList" ) then
        
        AddRandomObjectByList( quotient_cat,
            function( quotient_cat, L )
              return ObjectConstructor( quotient_cat, RandomObjectByList( UnderlyingCategory( quotient_cat ), L ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedSourceAndRangeByList" ) then
        
        AddRandomMorphismWithFixedSourceAndRangeByList( quotient_cat,
            function( quotient_cat, S, R, L )
                local alpha;
                alpha := RandomMorphismWithFixedSourceAndRangeByList( UnderlyingCategory( quotient_cat ), UnderlyingCell( S ), UnderlyingCell( R ), L );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedSourceByList" ) then
        
        AddRandomMorphismWithFixedSourceByList( quotient_cat,
            function( quotient_cat, S, L )
                local alpha;
                alpha := RandomMorphismWithFixedSourceByList( UnderlyingCategory( quotient_cat ), UnderlyingCell( S ), L );
                return MorphismConstructor( quotient_cat,  S, alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismWithFixedRangeByList" ) then
        
        AddRandomMorphismWithFixedRangeByList( quotient_cat,
            function( quotient_cat, R, L )
                local alpha;
                alpha := RandomMorphismWithFixedRangeByList( UnderlyingCategory( quotient_cat ), UnderlyingCell( R ), L );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, R );
        end );
        
    fi;
    
    if CanCompute( cat, "RandomMorphismByList" ) then
        
        AddRandomMorphismByList( quotient_cat,
            function( quotient_cat, L )
                local alpha;
                alpha := RandomMorphismByList( UnderlyingCategory( quotient_cat ), L );
                return MorphismConstructor( quotient_cat,  ObjectConstructor( quotient_cat, Source( alpha ) ), alpha, ObjectConstructor( quotient_cat, Range( alpha ) ) );
        end );
        
    fi;
    
end );


##
InstallOtherMethod( LaTeXOutput,
            [ IsQuotientCapCategoryObject ],
  
  o -> LaTeXOutput( UnderlyingCell( o ) )
);

##
InstallOtherMethod( LaTeXOutput,
            [ IsQuotientCapCategoryMorphism ],
  
  alpha -> LaTeXOutput( UnderlyingCell( alpha ) )
);
