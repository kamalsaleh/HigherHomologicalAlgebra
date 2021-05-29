#################################
##
##  Declarations
##
#################################

#! @Chapter Exact and Frobenius Categories
#! @Section GAP categories

DeclareGlobalVariable( "CAP_INTERNAL_FROBENIUS_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "FROBENIUS_CATEGORIES_METHOD_NAME_RECORD" );

#! @Description
#! The &GAP; category of short sequences.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryShortSequence", IsCapCategoryObject );

#! @Description
#! The &GAP; category of morphisms of short sequences.
#! @Arguments seq_mor
DeclareCategory( "IsCapCategoryMorphismOfShortSequences", IsCapCategoryMorphism );

#! @Description
#! The &GAP; category of short exact sequences.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryShortExactSequence", IsCapCategoryShortSequence );

#! @Description
#! The &GAP; category of conflations. If a short sequence is a conflation, then it is a short exact sequence.
#! @Arguments seq_obj
DeclareCategory( "IsCapCategoryConflation", IsCapCategoryShortExactSequence );

####################################
##
#! @Section Forbenius Categories Operations
##
####################################

#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences.
#! @Arguments C
DeclareProperty( "IsExactCategory", IsCapCategory );

#! @Description
#!  The argument is a pair of morphisms $\iota:A\to B$ and $\pi:B\to C$.
#!  The output is whether or not the pair $(\iota,\pi)$ defines a conflation.
#! @Arguments iota, pi
#! @Returns a boolian
DeclareOperation( "IsConflationPair",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsConflationPair",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$.
#!  The output is the cokernel object $C$ of $\iota$.
#! @Arguments iota
#! @Returns an object $C$
DeclareAttribute( "CokernelObjectOfInflation", IsCapCategoryMorphism );

DeclareOperation( "AddCokernelObjectOfInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelObjectOfInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCokernelObjectOfInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCokernelObjectOfInflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$. The output is a deflation $\pi(\iota):B\to C$ with
#!  $C=\mathrm{CokernelObjectOfInflation}(\iota)$ such that
#!  the pair $(\iota,\pi(\iota))$ defines a conflation.
#! @Arguments iota
#! @Returns a deflation $B\to C$
DeclareAttribute( "CokernelProjectionOfInflation", IsCapCategoryMorphism );

DeclareOperation( "AddCokernelProjectionOfInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjectionOfInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCokernelProjectionOfInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCokernelProjectionOfInflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an inflation $\iota:A\to B$ and an object $C=\mathrm{CokernelObjectOfInflation}(\iota)$.
#!  The output is a deflation $\pi(\iota):B\to C$ such that $(\iota,\pi(\iota))$ defines a conflation.
#! @Arguments iota, C
#! @Returns a deflation $B\to C$
DeclareOperation( "CokernelProjectionOfInflationWithGivenCokernelObjectOfInflation",
    [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddCokernelProjectionOfInflationWithGivenCokernelObjectOfInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddCokernelProjectionOfInflationWithGivenCokernelObjectOfInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddCokernelProjectionOfInflationWithGivenCokernelObjectOfInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddCokernelProjectionOfInflationWithGivenCokernelObjectOfInflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an inflation $\iota: A \rightarrow B$
#! and a test morphism $\tau: B \rightarrow T$ satisfying $\comp{\iota}{\tau} \sim 0$.
#! The output is the morphism $\lambda: C \rightarrow T$ with $C=\mathrm{CokernelObjectOfInflation}(\iota)$ and $\lambda$ is
#! given by the universal property of the cokernel object, i.e., $\comp{\pi(\iota)}{\lambda} \sim \tau$ where
#! $\pi(\iota) = \mathrm{CokernelProjectionOfInflation}(\iota)$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] & B \arrow[r, "\pi(\iota)", two heads] \arrow[rd, "\tau"'] & C \arrow[d, "\exists!~\lambda", dashed] \\ & & \phantom{.}T.
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments iota, tau
DeclareOperation( "ColiftAlongCokernelProjectionOfInflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftAlongCokernelProjectionOfInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongCokernelProjectionOfInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongCokernelProjectionOfInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongCokernelProjectionOfInflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a deflation $\pi: B \rightarrow C$ and a morphism $\tau: B \to T$
#! such that $\tau$ is coliftable along $\pi$. That is, $\comp{\iota(\pi)}{\tau} \sim 0$.
#! The output is the unique colift morphism $\lambda:C\to T$ of $\tau$ along $\pi$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! K \arrow[r, "\iota(\pi)", hook] & B \arrow[r, "\pi", two heads] \arrow[rd, "\tau"'] & C \arrow[d, "\exists !~\lambda", dashed] \\
#!                                &                                                   & \phantom{.}T. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments pi, tau
DeclareOperation( "ColiftAlongDeflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$.
#!  The output is the kernel object $K$ of $\pi$.
#! @Arguments pi
#! @Returns an object $K$
DeclareAttribute( "KernelObjectOfDeflation", IsCapCategoryMorphism );

DeclareOperation( "AddKernelObjectOfDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelObjectOfDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddKernelObjectOfDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddKernelObjectOfDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$.
#!  The output is an inflation $\iota(\pi):K\to B$ with
#!  $K=\mathrm{KernelObjectOfDeflation}(\pi)$ such that
#!  the pair $(\iota(\pi),\pi)$ defines a conflation.
#! @Arguments pi
#! @Returns an inflation $K\to B$
DeclareAttribute( "KernelEmbeddingOfDeflation", IsCapCategoryMorphism );

DeclareOperation( "AddKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a deflation $\pi:B\to C$ and an object $K=\mathrm{KernelObjectOfDeflation}(\pi)$.
#!  The output is an inflation $\iota(\pi):K\to B$ such that
#!  the pair $(\iota(\pi),\pi)$ defines a conflation.
#! @Arguments pi, K
#! @Returns an inflation $K\to B$
DeclareOperation( "KernelEmbeddingOfDeflationWithGivenKernelObjectOfDeflation",
  [ IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddKernelEmbeddingOfDeflationWithGivenKernelObjectOfDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddKernelEmbeddingOfDeflationWithGivenKernelObjectOfDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddKernelEmbeddingOfDeflationWithGivenKernelObjectOfDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddKernelEmbeddingOfDeflationWithGivenKernelObjectOfDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi: B \rightarrow C$
#!  and a test morphism $\tau: T \rightarrow B$ satisfying $\comp{\tau}{\pi} \sim 0$.
#!  The output is the morphism $\lambda: T \rightarrow K$ with $K=\mathrm{KernelObjectOfDeflation}(\pi)$ and $\lambda$ is
#!  given by the universal property of the kernel object, i.e., $\comp{\lambda}{\iota(\pi)} \sim \tau$ where
#!  $\iota(\pi) = \mathrm{KernelEmbeddingOfDeflation}(\pi)$.
#!  @BeginLatexOnly
#!  \begin{center}
#!  \begin{tikzcd}
#!  K \arrow[r, "\iota(\pi)", hook]                             & B \arrow[r, "\pi", two heads] & C \\
#!  \phantom{.}T. \arrow[ru, "\tau"'] \arrow[u, "\exists!~\lambda", dashed] &                               &  
#!  \end{tikzcd}
#!  \end{center}
#!  @EndLatexOnly
#! @Returns a morphism $T \to K$
#! @Arguments pi, tau
DeclareOperation( "LiftAlongKernelEmbeddingOfDeflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftAlongKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongKernelEmbeddingOfDeflation",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are an inflation $\iota: A \rightarrow B$ and a morphism $\tau: T \to B$
#! such that $\tau$ is liftable along $\iota$. That is, $\comp{\tau}{\pi(\iota)} \sim 0$.
#! The output is the unique lift morphism $\lambda:T\to A$ of $\tau$ along $\iota$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] & B \arrow[r, "\pi(\iota)", two heads] & C \\
#! \phantom{.}T. \arrow[ru, "\tau"'] \arrow[u, "\exists!~\lambda", dashed] &&
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Returns a morphism $C \to T$
#! @Arguments iota, tau
DeclareOperation( "LiftAlongInflation",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongInflation",
                  [ IsCapCategory, IsList ] );

#! @Subsection Exact Fiber Product
#!
#! Given a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$, an exact fiber product diagram of $(\pi,\alpha)$ is defined by an object $A\times_C B$, a morphism $p_A:A\times_C B\to A$
#! and a deflation $p_B:A\times_C B\to B$ such that $\comp{p_A}{\pi}\sim \comp{p_B}{\alpha}$ and for any two morphisms $p'_A:T\to A,p'_B:T\to B$ with $\comp{p'_A}{\pi}\sim \comp{p'_B}{\alpha}$, there exists
#! a unique morphism $u:T\to A\times_C B$ with $\comp{u}{p_A} \sim p'_A$ and $\comp{u}{p_B} \sim p'_B$.
#! @BeginLatexOnly
#! \begin{center}
#!        \begin{tikzcd}
#!            T \arrow[rrd, "p'_A"] \arrow[rdd, "p'_B"'] \arrow[rd, "u" description, dashed] &                                                           &                               \\
#!                                                                                   & A\times_C B \arrow[r, "p_A"', dashed] \arrow[d, "p_B", two heads, dashed] & A \arrow[d, "\pi", two heads] \\
#!                                                                                   & B \arrow[r, "\alpha"']                                    & C.                          
#!            \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! @Description
#! The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#! The output is the fiber product object $A\times_C B$ of $\pi$ and $\alpha$.
#! @Returns an object
#! @Arguments pi, alpha
DeclareOperation( "ExactFiberProduct", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#!  The output is a morphism $p_A:A\times_C B \to A$ which is a part of a fiber product diagram of $\pi$ and $\alpha$.
#! @Returns a morphism $p_A:A\times_C B\to A$
#! @Arguments pi, alpha
DeclareOperation( "ProjectionInFirstFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInFirstFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a deflation $\pi:A\to C$ and a morphism $\alpha:B\to C$.
#!  The output is a morphism $p_B:A\times_C B \to B$ which is a part of a fiber product diagram of $\pi$ and $\alpha$.
#! @Returns a morphism $p_B:A\times_C B\to B$
#! @Arguments pi, alpha
DeclareOperation( "ProjectionInSecondFactorOfExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddProjectionInSecondFactorOfExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Description
#! The arguments are a deflation $\pi:A\to C$ and three morphisms $\alpha:B\to C$, $p'_A:T\to A$ and $p'_B:T\to B$ such that  $\comp{p'_A}{\pi} \sim \comp{p'_B}{\alpha}$.
#! The output is the universal morphism $u:T\to A\times_C B$ with $\comp{u}{p_A} \sim p'_A$ and $\comp{u}{p_B}\sim p'_B$.
#! @Returns a morphism $u:T \to A \times_C B$
#! @Arguments pi, alpha, pprime_A, pprime_B
DeclareOperation( "UniversalMorphismIntoExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProduct",
                  [ IsCapCategory, IsList ] );


DeclareOperation( "UniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
    [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismIntoExactFiberProductWithGivenExactFiberProduct",
                  [ IsCapCategory, IsList ] );

#! @Subsection Exact Pushout
#!  Given an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$, an exact pushout diagram of $(\iota,\alpha)$ is defined by an object $A\oplus_C B$, a morphism $q_A:A \to A\oplus_C B$
#!  and an inflation $q_B:B\to A\oplus_C B$ such that $\comp{\iota}{q_A} \sim \comp{\alpha}{q_B}$ and for any two morphisms $q'_A:A\to T,q'_B:B\to T$ with
#!  $\comp{\iota}{q'_A}\sim \comp{\alpha}{q'_B}$, there exists a unique morphism $u: A\oplus_C B \to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{ u} \sim q'_B$.
#! @BeginLatexOnly
#! \begin{center}
#!        \begin{tikzcd}
#!            C \arrow[r, "\alpha"] \arrow[d, "\iota"', hook] & B \arrow[d, "q_B"', hook] \arrow[rdd, "q'_B"] &   \\
#!            A \arrow[r, "q_A"] \arrow[rrd, "q'_A"']         & A \oplus_C B \arrow[rd, "u" description]      &   \\
#!                                                            &                                               & T.
#!        \end{tikzcd}
#! \end{center}
#! @EndLatexOnly


#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is the pushout object $A\oplus_C B$ of $\iota$ and $\alpha$.
#! @Returns an object
#! @Arguments iota, alpha
DeclareOperation( "ExactPushout", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is a morphism $q_A:A \to A\oplus_C B$ which is a part of a pushout diagram of $\iota$ and $\alpha$.
#! @Returns a morphism $A \to A\oplus_C B$
#! @Arguments iota, alpha
DeclareOperation( "InjectionOfFirstCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfFirstCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );


#! @Description
#!  The arguments are an inflation $\iota:C\to A$ and a morphism $\alpha:C\to B$.
#!  The output is an inflation $q_B:B \to A\oplus_C B$ which is a part of a pushout diagram of $\iota$ and $\alpha$.
#! @Returns a inflation $B \to A\oplus_C B$
#! @Arguments iota, alpha
DeclareOperation( "InjectionOfSecondCofactorOfExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInjectionOfSecondCofactorOfExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a inflation $\iota:C\to A$ and three morphisms $\alpha:C\to B$, $q'_A:A\to T$ 
#!  and $q'_B:B\to T$ such that $\comp{\iota}{ q'_A}\sim \comp{\alpha}{ q'_B}$.
#!  The output is the universal morphism $u:A\oplus_C B\to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{u} \sim q'_B$.
#! @Returns a morphism $A\oplus_C B \to T$
#! @Arguments iota, alpha, qprime_A, qprime_B
DeclareOperation( "UniversalMorphismFromExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a inflation $\iota:C\to A$, three morphisms $\alpha:C\to B$, $q'_A:A\to T$,
#!  $q'_B:B\to T$ and an object $P=A\oplus_C B=\mathrm{ExactPushout}(\iota,\alpha)$
#!  such that $\comp{\iota}{ q'_A}\sim \comp{\alpha}{ q'_B}$.
#!  The output is the universal morphism $u:P \to T$ with $\comp{q_A}{ u}\sim q'_A$ and $\comp{q_B}{u} \sim q'_B$.
#! @Returns a morphism $P \to T$
#! @Arguments iota, alpha, qprime_A, qprime_B, P
DeclareOperation( "UniversalMorphismFromExactPushoutWithGivenExactPushout",
  [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddUniversalMorphismFromExactPushoutWithGivenExactPushout",
                  [ IsCapCategory, IsList ] );

#! @Subsection Exact Categories With Enough E-projectives
#!  Let $(\CC,\EE)$ be an exact category. An object $P$ is called $\mathcal{E}$-projective if for every
#!  morphisms $\tau:P\to C$ and every deflation $\pi:B\to C$, there exists a lift morphism $\lambda:P\to B$
#!  of $\tau$ along $\pi$, i.e., $\comp{\lambda}{\pi}=\tau$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#!                                & P \arrow[d, "\tau"] \arrow[ld, "\lambda"', dashed] \\
#! B \arrow[r, "\pi"', two heads] & C. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#!  The exact category $(\CC,\EE)$ is said to have enough $\EE$-projectives if for each object $A$ in $\CC$, there exists
#!  a deflation $p_A:P_A \to A$ where $P_A$ is an $\EE$-projecitve object.

#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences and $(\CC,\EE)$ has enough $\EE$-projectives.
#! @Arguments C
DeclareProperty( "IsExactCategoryWithEnoughExactProjectives", IsCapCategory );

#! @Description
#!  The argument is an object $P$ in $\CC$.
#!  The output is whether or not $P$ is an $\EE$-projective object.
#! @Returns a boolian 
#! @Arguments P
DeclareProperty( "IsExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are a morphism $\tau:P\to C$ where $P$ is an $\EE$-projective object
#!  and a deflation $\pi:B\to C$.
#!  The output is a lift morphism $\lambda:P\to B$ of $\tau$ along $\pi$, i.e.,
#!  $\comp{\lambda}{\pi} \sim \tau$.
#! @Returns a morphism $\lambda:P\to B$
#! @Arguments tau, pi
DeclareOperation( "ExactProjectiveLift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactProjectiveLift",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an $\EE$-projective object $P_A$ such that
#!  there exists a deflation $P_A \to A$.
#! @Returns an $\EE$-projective object 
#! @Arguments A
DeclareAttribute( "SomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is a deflation morphism $p_A:P_A \to A$ where
#!  $P_A = \mathrm{SomeExactProjectiveObject}(A)$.
#! @Returns a deflation $P_A \to A$
#! @Arguments A
DeclareAttribute( "DeflationFromSomeExactProjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );


#! @Subsection Exact Categories With Enough E-injecitves
#!  Let $(\CC,\EE)$ be an exact category. An object $I$ is called $\mathcal{E}$-injective if for
#!  every inflation $\iota:A\to B$ and every morphism $\tau:A \to I$, there exists a colift morphism
#!  of $\tau$ along $\iota$.
#!  @BeginLatexOnly
#!  \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\iota", hook] \arrow[d, "\tau"'] & B \arrow[ld, "\lambda", dashed]                \\
#! I                                             & {}
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#!  The exact category $(\CC,\EE)$ is said to have enough $\EE$-injectives if for each object $A$ in $\CC$, there exists
#!  an inflation $\iota_A:A \to I_A$ where $I_A$ is an $\EE$-injective object.


#! @Description
#!  The input is a &CAP; category. The output is <C>true</C> if $\CC$ is an exact category with respect to some
#!  class $\EE$ of short exact sequences and $(\CC,\EE)$ has enough $\EE$-injectives.
#! @Arguments C
DeclareProperty( "IsExactCategoryWithEnoughExactInjectives", IsCapCategory );

#! @Description
#!  The argument is an object $I$ in $\CC$.
#!  The output is whether or not $I$ is an $\EE$-injective object.
#! @Returns a boolian
#! @Arguments I
DeclareProperty( "IsExactInjectiveObject", IsCapCategoryObject );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an inflation $\iota:A\to B$ and a morphism $\tau:A\to I$
#!  where $I$ is an $\EE$-injective object.
#!  The output is a colift morphism $\lambda:B \to I$ of $\tau$ along $\iota$, i.e.,
#!  $\comp{\iota}{\lambda} \sim \tau$.
#! @Returns a morphism $\lambda:B \to I$
#! @Arguments iota, tau
DeclareOperation( "ExactInjectiveColift", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddExactInjectiveColift",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an $\EE$-injective object $I_A$ such that
#!  there exists an inflation $A \to I_A$.
#! @Returns an $\EE$-injective object 
#! @Arguments A
DeclareOperation( "SomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$ in $\CC$.
#!  The output is an inflation $\iota_A:A \to I_A$ where
#!  $I_A = \mathrm{SomeExactInjectiveObject}(A)$.
#! @Returns an inflation $A \to I_A$
#! @Arguments A
DeclareOperation( "InflationIntoSomeExactInjectiveObject", [ IsCapCategoryObject ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a &CAP; category. The output is <C>true</C> if 
#!  * $\CC$ is exact with respect to some class $\EE$ of short exact sequences,
#!  * $(\CC,\EE)$ has enough $\EE$-projectives and $\EE$-injectives,
#!  * an object in $\CC$ is $\EE$-projective if and only if it is $\EE$-injective.
#! @Arguments C
DeclareProperty( "IsFrobeniusCategory", IsCapCategory );


#! @Description
#!  The argument if a morphism $\alpha:A\to B$ in an exact category $(\CC,\EE)$ with enough $\EE$-projectives.
#!  The output is whether or not $\alpha$ lifts along $p_B:P_B\to B$ where $p_B=\mathrm{DeflationFromSomeExactProjectiveObject}(B)$.
#! @Arguments alpha
DeclareProperty( "IsLiftableAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsLiftableAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A\to B$ such that $\alpha$ lifts along $\p_B:P_B \to B$ where
#!  $p_B=\mathrm{DeflationFromSomeExactProjectiveObject}(B)$.
#!  The output is a lift morphism $\lambda: A \to P_B$ of $\alpha$ along $\p_B$.
#! @Arguments alpha
DeclareAttribute( "LiftAlongDeflationFromSomeExactProjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddLiftAlongDeflationFromSomeExactProjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument if a morphism $\alpha:A\to B$ in an exact category $(\CC,\EE)$ with enough $\EE$-injectives.
#!  The output is whether or not $\alpha$ colifts along $\iota_A:A\to I_A$ where $\iota_A=\mathrm{InflationIntoSomeExactInjectiveObject}(A)$.
#! @Arguments alpha
DeclareProperty( "IsColiftableAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddIsColiftableAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A\to B$ such that $\alpha$ colifts along $\iota_A:A \to I_A$ where
#!  $\iota_A=\mathrm{InflationIntoSomeExactInjectiveObject}(A)$.
#!  The output is a colift morphism $\lambda: I_A \to B$ of $\alpha$ along $\iota_A$.
#! @Arguments alpha
DeclareAttribute( "ColiftAlongInflationIntoSomeExactInjectiveObject", IsCapCategoryMorphism );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsFunction, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList, IsInt ] );
DeclareOperation( "AddColiftAlongInflationIntoSomeExactInjectiveObject",
                  [ IsCapCategory, IsList ] );

#################################
##
## Methods 
##
#################################

DeclareAttribute( "CategoryOfShortSequences", IsCapCategory );

DeclareOperation( "CreateShortSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "CreateShortExactSequence", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );
           
DeclareOperation( "CreateConflation", 
                      [ IsCapCategoryMorphism, IsCapCategoryMorphism ] );

DeclareOperation( "SchanuelsIsomorphism", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism, IsString ] );

DeclareAttribute( "IsShortExactSequence_", IsCapCategoryShortSequence );
#################################
##
##  Attributes
##
#################################

DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_FROBENIUS_CATEGORY", IsCapCategory );
DeclareAttribute( "INSTALL_LOGICAL_IMPLICATIONS_FOR_EXACT_CATEGORY", IsCapCategory );
        
#################################
##
## Properties
##
#################################

DeclareAttribute( "AsResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromRangeToRangeOfResidueClassOfInflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToRangeFromRangeOfResidueClassOfInflation", IsStableCategoryMorphism );

DeclareAttribute( "AsResidueClassOfDeflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoFromSourceToSourceOfResidueClassOfDefflation", IsStableCategoryMorphism );
DeclareAttribute( "IsoToSourceFromSourceOfResidueClassOfDeflation", IsStableCategoryMorphism );


KeyDependentOperation( "MorphismAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\^", [ IsCapCategoryShortSequence, IsInt ] );

KeyDependentOperation( "ObjectAt", IsCapCategoryShortSequence, IsInt, ReturnTrue );
DeclareOperation( "\[\]", [ IsCapCategoryShortSequence, IsInt ] );

