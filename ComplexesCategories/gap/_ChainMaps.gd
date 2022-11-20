# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Declarations
#
#!  @Chapter Complexes morphisms
##
#############################################################################

#!  @Section Categories and filters

#!  @BeginGroup 10
#!  @Description
#!  Gap-categories for chain and cochains morphisms.
#!  @Arguments phi
DeclareCategory( "IsChainOrCochainMorphism", IsCapCategoryMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedBelowChainOrCochainMorphism", IsChainOrCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedAboveChainOrCochainMorphism", IsChainOrCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedChainOrCochainMorphism", IsBoundedBelowChainOrCochainMorphism and IsBoundedAboveChainOrCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsChainMorphism", IsChainOrCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedBelowChainMorphism", IsBoundedBelowChainOrCochainMorphism and IsChainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedAboveChainMorphism", IsBoundedAboveChainOrCochainMorphism and IsChainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedChainMorphism", IsBoundedChainOrCochainMorphism and IsChainMorphism );
#!  @Arguments phi
DeclareCategory( "IsCochainMorphism", IsChainOrCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedBelowCochainMorphism", IsBoundedBelowChainOrCochainMorphism and IsCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedAboveCochainMorphism", IsBoundedAboveChainOrCochainMorphism and IsCochainMorphism );
#!  @Arguments phi
DeclareCategory( "IsBoundedCochainMorphism", IsBoundedChainOrCochainMorphism and IsCochainMorphism );
#!  @EndGroup
#!  @Group 10

DeclareCategoryFamily( "IsChainMorphism" );
DeclareCategoryFamily( "IsCochainMorphism" );

######################################
#
# Constructors of co-chain morphisms
#
######################################

DeclareOperation( "CreateComplexMorphism", [ IsCochainComplexCategory, IsCochainComplex, IsCochainComplex, IsList ] );

#!  @Section Creating chain and cochain morphisms

#!  @Description
#!  The input is two chain complexes $C,D$ and a $\mathbb{Z}$-function $l$.
#!  The output is the chain morphism $\phi:C\rightarrow D$ defined by $\phi_i :=l[i]$.
#!  @Arguments C, D, l
#!  @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                   [ IsChainComplex, IsChainComplex, IsZFunction ] );

#!  @Description
#!  The input is two chain complexes $C,D$, dense list $l$ and an integer $k$.
#!  The output is the chain morphism $\phi:C\rightarrow D$ such that $\phi_{k}=l[1]$, $\phi_{k+1}=l[2]$, etc.
#!  @Arguments C, D, l, k
#!  @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                  [ IsChainComplex, IsChainComplex, IsDenseList, IsInt ] );

#!  @Description
#!  The output is the chain morphism $\phi:C\rightarrow D$, where $d^C_m = c[ 1 ], d^C_{m+1} =c[ 2 ],$ etc.
#!  $d^D_n = d[ 1 ], d^D_{n+1} =d[ 2 ],$ etc. and $\phi_{k}=l[1]$, $\phi_{k+1}=l[2]$, etc.
#!  @Arguments c,m,d,n,l, k
#!  @Returns a chain morphism
DeclareOperation( "ChainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );


#!  @Description
#!  The input is two cochain complexes $C,D$ and a $\mathbb{Z}$-function $l$.
#!  The output is the cochain morphism $\phi:C\rightarrow D$ defined by $\phi_i :=l[i]$.
#!  @Arguments C, D, l
#!  @Returns a cochain morphism
DeclareOperation( "CochainMorphism",
                   [ IsCochainComplex, IsCochainComplex, IsZFunction ] );


#!  @Description
#!  The input is two cochain complexes $C,D$, dense list $l$ and an integer $k$.
#!  The output is the cochain morphism $\phi:C\rightarrow D$ such that $\phi^{k}=l[1]$, $\phi^{k+1}=l[2]$, etc.
#!  @Arguments C, D, l, k
#!  @Returns a chain morphism
DeclareOperation( "CochainMorphism",
                  [ IsCochainComplex, IsCochainComplex, IsDenseList, IsInt ] );

#!  @Description
#!  The output is the cochain morphism $\phi:C\rightarrow D$, where $C^m = c[ 1 ], C^{m+1} =c[ 2 ],$ etc.
#!  $D^n = d[ 1 ], D^{n+1} =d[ 2 ],$ etc. and $\phi^{k}=l[1]$, $\phi^{k+1}=l[2]$, etc.
#!  @Arguments c,m,d,n,l, k
#!  @Returns a cochain morphism
DeclareOperation( "CochainMorphism",
                   [ IsDenseList, IsInt, IsDenseList, IsInt, IsDenseList, IsInt ] );

#! @BeginGroup 41
#! @Description
#! The input is a morphism $f:a\rightarrow b$ in a category $A$. The output is chain (resp. cochain) morphism $f_{\bullet}\in\mathrm{Ch}_\bullet(A)(f^{\bullet}\in\mathrm{Ch}^\bullet(A))$
#! where $f^{\bullet}_n=f( f_{\bullet}^n=f)$ and $f^{\bullet}_i=0(f_{\bullet}^i=0)$ whenever $i\neq n$.
#! @Arguments f, n
#! @Returns a (co)chain morphism
KeyDependentOperation( "StalkChainMorphism", IsCapCategoryMorphism, IsInt, ReturnTrue );
#! @EndGroup
#! @Group 41
#! @Arguments f, n
KeyDependentOperation( "StalkCochainMorphism", IsCapCategoryMorphism, IsInt, ReturnTrue );

#! @BeginGroup 42
#! @Description
#! The input is a (co)chain complex morphism $\phi:C\to D$ and an integer $n$. The outout is the
#! associated morphism between the (co)homology objects of $C$ resp. $D$ at index $n$.
#! @Arguments phi, n
#! @Returns a morphism
KeyDependentOperation( "HomologyFunctorialAt", IsChainMorphism, IsInt, ReturnTrue );
#! @EndGroup
#! @Group 42
#! @Arguments phi, n
KeyDependentOperation( "CohomologyFunctorialAt", IsCochainMorphism, IsInt, ReturnTrue );

######################################
#
#  Attribtes, Operations ..
#
######################################

#!  @Section Attributes

#!  @Description
#!  The output is morphisms of the chain or cochain morphism as a $\mathbb{Z}$-function.
#!  @Arguments phi
#!  @Returns $\mathbb{Z}$-function
DeclareAttribute( "Morphisms", IsChainOrCochainMorphism );

#! @Description
#! The input is a cochain morphism $\phi$ and the output is the associated chain morphism.
#! @Arguments phi
#! @Returns a chain morphism
DeclareAttribute( "AsChainMorphism", IsChainOrCochainMorphism );

#! @Description
#! The input is a chain morphism $\phi$ and the output is the associated cochain morphism.
#! @Arguments phi
#! @Returns a cochain morphism
DeclareAttribute( "AsCochainMorphism", IsChainOrCochainMorphism );

#! @Description
#! The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is its
#! mapping cone chain (resp. cochain) complex $\mathrm{Cone}(\phi )$.
#! @BeginLatexOnly
#! If the input is a chain complex then the mapping cone is the chain complex whose differential at index $n$ is defined by
#! \begin{center}
#! \begin{tikzpicture}[x=4cm,y=0.7cm,transform shape,
#! mylabel/.style={thick, draw=black,
#! align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white}]
#! \node (0V3) at (0,3) {$C_{n-2}$};
#! \node (0V2) at (0,2) {$\bigoplus$};
#! \node (0V1) at (0,1) {$D_{n-1}$};
#! \node (1V3) at (1,3) {$C_{n-1}$};
#! \node (1V2) at (1,2) {$\bigoplus$};
#! \node (1V1) at (1,1) {$D_{n}$};
#!         \draw[->,thick] (1V3)-- node[above]{$-d^C_{n-1}$} (0V3);
#!         \draw[->,thick] (1V3)-- node[above]{$\phi_{n-1}$} (0V1);
#! \draw[->,thick] (1V1)-- node[below]{$d^D_{n}$} (0V1);
#! \end{tikzpicture}
#! \end{center}
#! If the input is a cochain complex then the mapping cone is the cochain complex whose differential at index $n$ is defined by
#! \begin{center}
#! \begin{tikzpicture}[x=4cm,y=0.7cm,transform shape,
#! mylabel/.style={thick, draw=black,
#! align=center, minimum width=0.5cm, minimum height=0.5cm,fill=white}]
#! \node (0V3) at (0,3) {$C^{n+1}$};
#! \node (0V2) at (0,2) {$\bigoplus$};
#! \node (0V1) at (0,1) {$D^{n}$};
#! \node (1V3) at (1,3) {$C^{n+2}$};
#! \node (1V2) at (1,2) {$\bigoplus$};
#! \node (1V1) at (1,1) {$D^{n+1}$};
#! \draw[<-,thick] (1V3)-- node[above]{$-d_C^{n+1}$} (0V3);
#! \draw[<-,thick] (1V1)-- node[below]{$\phi^{n+1}$} (0V3);
#! \draw[<-,thick] (1V1)-- node[below]{$d_D^{n}$} (0V1);
#! \end{tikzpicture}
#! \end{center}
#! @EndLatexOnly
#! @Arguments phi
#! @Returns complex
DeclareAttribute( "MappingCone", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C\rightarrow D$. The output is the natural injection
#!  $i:D\rightarrow \mathrm{Cone}(\phi )$.
#!  @Arguments phi
#!  @Returns chain (resp. cochain) morphism
DeclareAttribute( "NaturalInjectionInMappingCone", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain ( resp. cochain) morphism $\phi:C\rightarrow D$. The output is the natural projection
#!  $\pi:\mathrm{Cone}(\phi ) \rightarrow C[u]$ where $u=-1$ if $\phi$ is chain morphism and $u=1$ if $\phi$ is cochain morphism.
#!  @Arguments phi
#!  @Returns chain (resp. cochain) morphism
DeclareAttribute( "NaturalProjectionFromMappingCone", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is its
#!  mapping cylinder chain (resp. cochain) complex
#! @BeginLatexOnly
#! $\mathrm{Cyl}(\phi ):=\mathrm{Cone}(C \xrightarrow[]{\bigl( \begin{smallmatrix}-\phi & \mathrm{id}_C\end{smallmatrix}\bigr)} D \oplus C)$.
#! @EndLatexOnly
#!  @Arguments phi
#!  @Returns complex
DeclareAttribute( "MappingCylinder", IsChainOrCochainMorphism );

DeclareAttribute( "MappingCocylinder", IsChainOrCochainMorphism );
DeclareAttribute( "NaturalMorphismFromSourceInMappingCocylinder", IsChainOrCochainMorphism );
DeclareAttribute( "NaturalMorphismFromMappingCocylinderToRange", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is the natural embedding
#!  $C\rightarrow \mathrm{Cyl}(\phi )$. I.e., the composition
#! @BeginLatexOnly
#! $$C \xrightarrow[]{\bigl( \begin{smallmatrix}0 & \mathrm{id}_C\end{smallmatrix}\bigr)} D \oplus C \xrightarrow[]{\iota} \mathrm{Cone}(C \xrightarrow[]{\bigl( \begin{smallmatrix}-\phi & \mathrm{id}_C\end{smallmatrix}\bigr)} D \oplus C),$$
#! where $\iota := \mathrm{NaturalInjectionInMappingCone}\bigl(C \xrightarrow[]{\left( \begin{smallmatrix}-\phi & \mathrm{id}_C\end{smallmatrix}\right)} D \oplus C\bigr)$.
#! @EndLatexOnly
#!  @Arguments phi
#!  @Returns morphism
DeclareAttribute( "NaturalInjectionOfSourceInMappingCylinder", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is the natural embedding
#!  $D \rightarrow \mathrm{Cyl}(\phi )$. I.e., the composition
#! @BeginLatexOnly
#! $$D \xrightarrow[]{\bigl( \begin{smallmatrix}\mathrm{id}_D & 0 \end{smallmatrix}\bigr)} D \oplus C \xrightarrow[]{\iota} \mathrm{Cone}(C \xrightarrow[]{\bigl( \begin{smallmatrix}-\phi & \mathrm{id}_C\end{smallmatrix}\bigr)} D \oplus C),$$
#! where $\iota := \mathrm{NaturalInjectionInMappingCone}\bigl(C \xrightarrow[]{\left( \begin{smallmatrix}-\phi & \mathrm{id}_C\end{smallmatrix}\right)} D \oplus C\bigr)$.
#! @EndLatexOnly
#! This morphism can be proven to be quasi-isomorphism. See Weibel, page 21.
#!  @Arguments phi
#!  @Returns morphism
DeclareAttribute( "NaturalInjectionOfRangeInMappingCylinder" , IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is the natural morphism
#!  $\mathrm{Cyl}(\phi )\rightarrow D$.
#! @BeginLatexOnly
#! If the input is chains morphism then the natural map has in each homological index the morphism
#! $$C_{n-1}\oplus D_n \oplus C_n \xrightarrow[]{ \biggl( \begin{smallmatrix}0 \\ \mathrm{id}^D_n \\ \phi_n \end{smallmatrix}\biggr)} D_n.$$
#! If the input is cochains morphism then the natural map has in each cohomological index the morphism
#! $$C^{n+1}\oplus D^n \oplus C^n \xrightarrow[]{ \biggl( \begin{smallmatrix}0 \\ \mathrm{id}_D^n \\ \phi^n \end{smallmatrix}\biggr)} D^n.$$
#! @EndLatexOnly
#! It can be shown that $D$ and $\mathrm{Cyl}(\phi )$ are homotopy equivalent.
#! This homotopy equivalence is given by the two morphisms
#! $$\mathrm{NaturalInjectionOfRangeInMappingCylinder}(\phi):D \rightarrow \mathrm{Cyl}(\phi )$$
#! and
#! $$\mathrm{NaturalMorphismFromMappingCylinderInRange}(\phi):\mathrm{Cyl}(\phi ) \rightarrow D.$$
#! See Weibel, page 21.
#!  @Arguments phi
#!  @Returns morphism
DeclareAttribute( "NaturalMorphismFromMappingCylinderInRange", IsChainOrCochainMorphism );

#!  @Description
#!  The input a chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is the natural morphism
#!  $\mathrm{Cyl}(\phi )\rightarrow \mathrm{Cone}(\phi )$.
#! @BeginLatexOnly
#! If the input is chains morphism then the natural map has in each homological index the morphism
#! $$C_{n-1}\oplus D_n \oplus C_n \xrightarrow[]{ \biggl( \begin{smallmatrix}\mathrm{id}^C_{n-1} & 0\\ 0 & -\mathrm{id}^D_{n}\\ 0 & 0 \end{smallmatrix}\biggr)} C_{n-1} \oplus D_n.$$
#! If the input is cochains morphism then the natural map has in each cohomological index the morphism
#! $$C^{n+1}\oplus D^n \oplus C^n \xrightarrow[]{ \biggl( \begin{smallmatrix}\mathrm{id}_C^{n+1} & 0\\ 0 & -\mathrm{id}_D^{n}\\ 0 & 0 \end{smallmatrix}\biggr)} C^{n+1} \oplus D^n.$$
#! @EndLatexOnly
#! It can be shown that $$0 \rightarrow C\xrightarrow[]{\alpha} \mathrm{Cyl}(\phi ) \xrightarrow[]{\beta} \mathrm{Cone}(\phi )\rightarrow 0$$ 
#! where $$\alpha := \mathrm{NaturalInjectionOfSourceInMappingCylinder}(\phi)$$
#! and
#! $$\beta := \mathrm{NaturalMorphismFromMappingCylinderInMappingCone}(\phi),$$
#! is a short exact sequence. See Weibel, page 21.
#!  @Arguments phi
#!  @Returns morphism
DeclareAttribute( "NaturalMorphismFromMappingCylinderInMappingCone", IsChainOrCochainMorphism );

#!  @Description
#!  The input is a null-homotopic chain (resp. cochain) morphism $\phi:C \rightarrow D$. The output is the homotopy morphisms given as 
#! a $\mathbb{Z}$-function $(h_i:C_i \rightarrow D_{i+1})$ ( resp. $(h_i:C_i \rightarrow D_{i-1})$ ). Note that this method 
#! can be called only if it is added to the category, see $\texttt{AddHomotopyMorphisms}$.
#!  @Arguments phi
#!  @Returns A ZFunction
DeclareAttribute( "HomotopyMorphisms", IsCapCategoryMorphism );


#DeclareOperation( "MappingConeColift", [ IsChainOrCochainMorphism, IsChainOrCochainMorphism ] );
#DeclareOperation( "MappingConePseudoFunctorial", [ IsChainOrCochainMorphism, IsChainOrCochainMorphism, IsChainOrCochainMorphism, IsChainOrCochainMorphism ] );


#!  @Section Properties

#!  @Description
#!  The input a chain ( resp. cochain) morphism $\phi:C\rightarrow D$. The output is **true** if $\phi$ is quasi-isomorphism and **false** otherwise. If $\phi$
#!  is not bounded an error is raised.


#!  @Arguments phi
DeclareProperty( "IsQuasiIsomorphism", IsChainOrCochainMorphism );

#! @Description
#! The input is a chain or cochain morphism
#! $\phi$ and output is **true** if  $\phi$ is null-homotopic and **false** otherwise.
#! @Arguments phi
DeclareProperty( "IsNullHomotopic", IsChainOrCochainMorphism );


#!  @Section Operations

#!  @Description
#!  The command sets an upper bound to the morphism $\phi$. An upper bound of $\phi$ is an integer $u$
#!  with $\phi_{i}= 0$ for $i>n$. The integer $u$ will be called **active** upper bound of $\phi$. If $\phi$ already has an
#!  active upper bound, say $u^\prime$, then $u^\prime$ will be replaced by $u$ only if $u^\prime>u$.
#!  @Arguments phi, n
#!  @Returns a side effect
DeclareOperation( "SetUpperBound", [ IsChainOrCochainMorphism, IsInt ] );

#!  @Description
#!  The command sets an lower bound to the morphism $\phi$. A lower bound of $\phi$ is an integer $l$
#!  with $\phi_{i}= 0$ for $l>i$. The integer $l$ will be called **active** lower bound of $\phi$. If $\phi$ already has an
#!  active lower bound, say $l^\prime$, then $l^\prime$ will be replaced by $l$ only if $l>l^\prime$.
#!  @Arguments phi, n
#!  @Returns a side effect
DeclareOperation( "SetLowerBound", [ IsChainOrCochainMorphism, IsInt ] );

#!  @Description
#!  The input is chain or cochain morphism $\phi$.
#!  The output is <A>true</A> if an upper bound has been set to $\phi$ and <A>false</A> otherwise.
#!  @Arguments phi
#!  @Returns true or false
DeclareOperation( "HasActiveUpperBound", [ IsChainOrCochainMorphism ] );

#!  @Description
#!  The input is chain or cochain morphism $\phi$.
#!  The output is <A>true</A> if a lower bound has been set to $\phi$ and <A>false</A> otherwise.
#!  @Arguments phi
#!  @Returns true or false
DeclareOperation( "HasActiveLowerBound", [ IsChainOrCochainMorphism ] );

#!  @Description
#!  The input is chain or cochain morphism. The output is its active upper bound if such has been set to $\phi$. Otherwise we get error.
#!  @Arguments phi
#!  @Returns an integer
DeclareOperation( "ActiveUpperBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "ActiveUpperBoundForSourceAndRange", [ IsChainOrCochainMorphism ] );

#!  @Description
#!  The input is chain or cochain morphism. The output is its active lower bound if such has been set to $\phi$. Otherwise we get error.
#!  @Arguments phi
#!  @Returns an integer
DeclareOperation( "ActiveLowerBound", [ IsChainOrCochainMorphism ] );

DeclareOperation( "ActiveLowerBoundForSourceAndRange", [ IsChainOrCochainMorphism ] );

#!  @Description
#! The input is chain (resp. cochain) morphism and an integer $n$. The output is the component
#! of $\phi$ in index $n$, i.e., $\phi_n$(resp. $\phi^n$).
#!  @Arguments phi, n
#!  @Returns a morphism

#!  @Description
#!  The input is chain (resp. cochain) morphism and an integer $n$. The output is the component of $\phi$ in index $n$, i.e., $\phi_n$(resp. $\phi^n$).
#!  @Arguments phi, n
#!  @Returns an integer
DeclareOperation( "IsQuasiIsomorphism", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

# DeclareOperation( "\*", [ IsRingElement, IsChainOrCochainMorphism ] );

#!  @Description
#!  The command gives back the list of indices between $m$ and $n$ where the complex morphism is not zero.
#!  @Arguments phi, m, n
DeclareOperation( "MorphismsSupport", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

DeclareOperation( "MorphismsSupport", [ IsBoundedChainOrCochainMorphism ] );

#!  @Description
#!  The command displays the components of the morphism between $m$ and $n$.
#!  @Arguments phi, m, n
DeclareOperation( "Display", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

##
DeclareOperation( "ViewChainOrCochainMorphism", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

##
DeclareOperation( "ViewChainOrCochainMorphism", [ IsBoundedChainOrCochainMorphism ] );

##
DeclareOperation( "ViewChainMorphism", [ IsChainMorphism, IsInt, IsInt ] );

##
DeclareOperation( "ViewChainMorphism", [ IsBoundedChainMorphism ] );

##
DeclareOperation( "ViewCochainMorphism", [ IsCochainMorphism, IsInt, IsInt ] );

##
DeclareOperation( "ViewCochainMorphism", [ IsBoundedCochainMorphism ] );

#!  @Description
#!  The command checks if the morphism is well defined between $m$ and $n$.
#!  @Arguments true or false
DeclareOperation( "IsWellDefined", [ IsChainOrCochainMorphism, IsInt, IsInt ] );

# @Description
#TODO
# @Arguments C, phi, D
# @Returns a morphism
DeclareOperation( "AsChainOrCochainMorphismOverCapFullSubcategory",
    [ IsChainOrCochainComplex, IsChainOrCochainMorphism, IsChainOrCochainComplex ] );

DeclareOperation( "AsChainMorphismOverCapFullSubcategory",
    [ IsChainComplex, IsChainMorphism, IsChainComplex ] );

DeclareOperation( "AsCochainMorphismOverCapFullSubcategory",
    [ IsCochainComplex, IsCochainMorphism, IsCochainComplex ] );

DeclareOperation( "MappingConeColift", [ IsChainOrCochainMorphism, IsChainOrCochainMorphism ] );

DeclareOperation( "MappingConePseudoFunctorial",
  [ IsChainOrCochainMorphism, IsChainOrCochainMorphism,
      IsChainOrCochainMorphism, IsChainOrCochainMorphism ] );

DeclareOperation( "MappingConeFunctorial",
  [ IsChainOrCochainMorphism, IsChainOrCochainMorphism,
      IsChainOrCochainMorphism, IsChainOrCochainMorphism ] );


#!  @Section Examples
#?  @InsertChunk vec_2

DeclareOperation( "BoxProduct",
    [ IsBoundedCochainMorphism, IsBoundedCochainMorphism, IsCapCategory ] );

DeclareOperation( "BoxProduct",
    [ IsBoundedChainMorphism, IsBoundedChainMorphism, IsCapCategory ] );

#######################################
#
#  Global functions and variables
#
#######################################

DeclareGlobalVariable( "PROPAGATION_LIST_FOR_CO_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "INSTALL_TODO_LIST_FOR_CO_CHAIN_MORPHISMS" );

DeclareGlobalFunction( "TODO_LIST_TO_CHANGE_MORPHISM_FILTERS_WHEN_NEEDED" );

DeclareAttribute( "LowerBoundOfComplexMorphism", IsChainOrCochainMorphism );


