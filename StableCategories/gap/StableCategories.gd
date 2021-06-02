# SPDX-License-Identifier: GPL-2.0-or-later
# StableCategories: Stable categories of additive categories
#
# Declarations
#

#! @Chapter Lifting and Colifting systems

#! @Section Systems of lifting objects

#! Let $\CC$ be an additive category. A system of lifting objects in $\CC$ consists of the following data:
#! * A distinguished class $\LL$ of objects.
#! * Every object $A$ is equipped with a  distinguished object $L_A$ in $\LL$ and a distinguished morphism $\ell_A:L_A \to A$.
#!   Furthermore, if $A$ belongs to $\LL$, then $\ell_A$ is a split-epimorphism.
#! * For every morphism $\alpha:A\to B$, there exists a morphism $L_{\alpha}$ with $\comp{L_\alpha}{\ell_B} \sim \comp{\ell_A}{\alpha}$, i.e., we get a commutative diagram:
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! L_A \arrow[r, "\exists~L_{\alpha}", dashed] \arrow[d, "\ell_A"'] & L_B \arrow[d, "\ell_B"] \\
#! A \arrow[r, "\alpha"']                                   & B.
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! @Description
#!  The argument is an object $A$.
#!  The output is whether or not $A$ belongs to $\LL$.
#! @Arguments A
DeclareProperty( "IsLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftingObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#!  The argument is an object $A$.
#!  The output is an object $L_A$ in $\LL$.
#! @Arguments A
#! @Returns an object in $\LL$
DeclareAttribute( "LiftingObject", IsCapCategoryObject );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$.
#!  The output is the distinguished morphism $\ell_A:L_A \to A$ where $L_A=\mathrm{LiftingObject}(A)$.
#! @Arguments A
#! @Returns a morphism $L_A \to A$
DeclareAttribute( "MorphismFromLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are two objects $A$ and $L_A=\mathrm{LiftingObject}(A)$.
#!  The output is the distinguished morphism $\ell_A:L_A \to A$.
#! @Arguments A, L_A
#! @Returns a morphism $L_A \to A$
DeclareOperation( "MorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a lifting object $A$ in $\LL$ and $L_A=\mathrm{LiftingObject}(A)$.
#!  The output is a section morphism $s_A:A \to L_A$ of $\ell_A = \mathrm{MorphismFromLiftingObjectWithGivenLiftingObject}(A,L_A)$.
#! @Arguments A, L_A
#! @Returns a morphism $A \to L_A$
DeclareOperation( "SectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
    [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObjectWithGivenLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a lifting object $A$ in $\LL$.
#!  The output is a section morphism $s_A:A \to L_A$ of $\ell_A = \mathrm{MorphismFromLiftingObject}(A)$.
#! @Arguments A
#! @Returns a morphism $A \to L_A$
DeclareAttribute( "SectionOfMorphismFromLiftingObject", IsCapCategoryObject );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddSectionOfMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The arguments are an object $L_A=\mathrm{LiftingObject}(A)$, a morphism $\alpha:A \to B$ and an object $L_B=\mathrm{LiftingObject}(B)$.
#!  The output is a morphism $L_{\alpha}:L_A \to L_B$ with $\comp{L_\alpha}{\ell_B} \sim \comp{\ell_A}{\alpha}$ where $\ell_A=\mathrm{MorphismFromLiftingObject}(A)$
#!  and $\ell_B=\mathrm{MorphismFromLiftingObject}(B)$.
#! @Arguments L_A, alpha, L_B
#! @Returns a morphism $L_A \to L_B$
DeclareOperation( "LiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddLiftingMorphismWithGivenLiftingObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A \to B$.
#!  The output is a morphism $L_{\alpha}:L_A \to L_B$ with $\comp{L_\alpha}{\ell_B} \sim \comp{\ell_A}{\alpha}$ where
#!  $L_A=\mathrm{LiftingObject}(A)$, $L_B=\mathrm{LiftingObject}(B)$, $\ell_A=\mathrm{MorphismFromLiftingObject}(A)$ and
#!  $\ell_B=\mathrm{MorphismFromLiftingObject}(B)$.
#! @Arguments alpha
#! @Returns a morphism $L_A \to L_B$
DeclareAttribute( "LiftingMorphism", IsCapCategoryMorphism );


#! @Description
#!  The argument is a morphism $\alpha:A \to B$.
#!  The output is whether or not $\alpha$ lifts along $\ell_B: L_B \to B$ where
#!  $\ell_B=\mathrm{MorphismFromLiftingObject}(B)$.
#! @Arguments alpha
DeclareProperty( "IsLiftableAlongMorphismFromLiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A \to B$ which lifts along $\ell_B:L_B \to B$, where $\ell_B=\mathrm{MorphismFromLiftingObject}(B)$.
#!  The output is a lift morphism $\lambda:A \to L_B$ of $\alpha$ along $\ell_B$, i.e., $\comp{\lambda}{\ell_B} \sim \alpha$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#!                                                       & L_B \arrow[d, "\ell_B"] \\
#! A \arrow[r, "\alpha"'] \arrow[ru, "\exists ~\lambda"] & \phantom{.}B. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Arguments alpha
#! @Returns a morphism $\lambda:A \to L_B$
DeclareAttribute( "WitnessForBeingLiftableAlongMorphismFromLiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingLiftableAlongMorphismFromLiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Section Examples for systems of lifting objects
#! @SectionLabel efsolo
#!  
#!  Let $(\CC,\EE)$ is an exact category with enough $\EE$-projective objects. For any object $A$, there exists a deflation $p_A:P_A \to A$ from some $\EE$-projective object $P_A$.
#!  We define $\LL$ by the class of all $\EE$-projective objects in $\CC$.
#!  For an object $A$ in $\CC$, we define the the distinguished object $L_A$ by $P_A$ and the distinguished morphism $\ell_A:L_A\to A$ by $p_A:P_A \to A$.
#!  If $A$ happens to be an $\EE$-projective object, then $\ell_A$ is a split-epimorphism and its section morphism $s_A:A \to L_A$ is given by the $\EE$-projective lift
#!  of $\id_A$ along the deflation $\ell_A$.
#!  For a morphism $\alpha: A \to B$, we define $L_\alpha:L_A \to L_B$ by the $\EE$-projective lift of $\comp{\ell_A}{\alpha}$ along the deflation $\ell_B$.
#! 
#!  Every abelian category $\CC$ is exact with respect to the class $\EE$ of **all** short exact sequences in $\CC$.
#!  The fact that in abelian categories every monomorphism is a kernel of its
#!  cokernel and every epimorphism is a cokernel of its kernel implies that
#!  a morphism in this category is an inflation if and only if it is a monomorphism; and is a deflation if and only if it is an epimorphism.
#!  It also implies that an object in $\CC$ is $\EE$-injective if and only if it is injective in the usual sense, and
#!  is $\EE$-projective if and only if it is projective in the usual sense.

#! @InsertChunk freyd_categories_graded_exterior_algebra-lifting-system

#! @Section Systems of colifting objects
#! 
#! Let $\CC$ be an additive category. A system of colifting objects in $\CC$ consists of the following data:
#! * A distinguished class $\QQ$ of objects.
#! * Every object $A$ is equipped with a  distinguished object $Q_A$ in $\QQ$ and a distinguished morphism $q_A:A \to Q_A$.
#!   Furthermore, if $A$ belongs to $\QQ$, then $q_A$ is a split-monomorphism.
#! * For every morphism $\alpha:A\to B$, there exists a morphism $Q_{\alpha}$ with $\comp{q_A}{Q_\alpha} \sim \comp{\alpha}{q_B}$, i.e., we get a commutative diagram:
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\alpha"] \arrow[d, "q_A"'] & B \arrow[d, "q_B"] \\
#! Q_A \arrow[r, "Q_\alpha"', dashed]      & \phantom{.}Q_B. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly


#! @Description
#!  The argument is an object $A$.
#!  The output is whether or not $A$ belongs to $\QQ$.
#! @Arguments A
DeclareProperty( "IsColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$.
#!  The output is an object $Q_A$ in $\QQ$.
#! @Arguments A
#! @Returns an object in $\QQ$
DeclareAttribute( "ColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is an object $A$.
#!  The output is the distinguished morphism $q_A:A \to Q_A$ where $Q_A=\mathrm{ColiftingObject}(A)$.
#! @Arguments A
#! @Returns a morphism $A \to Q_A$
DeclareAttribute( "MorphismToColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#!  The arguments are two objects $A$ and $Q_A=\mathrm{ColiftingObject}(A)$.
#!  The output is the distinguished morphism $q_A:A \to Q_A$.
#! @Arguments A, Q_A
#! @Returns a morphism $A \to Q_A$
DeclareOperation( "MorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a colifting object $A$ in $\QQ$ and $Q_A=\mathrm{ColiftingObject}(A)$.
#!  The output is a retraction morphism $r_A:Q_A \to A$ of $q_A = \mathrm{MorphismToColiftingObjectWithGivenColiftingObject}(A,Q_A)$.
#! @Arguments A, Q_A
#! @Returns a morphism $Q_A \to A$
DeclareOperation( "RetractionOfMorphismToColiftingObjectWithGivenColiftingObject", 
    [ IsCapCategoryObject, IsCapCategoryObject ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a colifting object $A$ in $\QQ$.
#!  The output is a retraction morphism $r_A:Q_A \to A$ of $q_A = \mathrm{MorphismToColiftingObject}(A)$.
#! @Arguments A
#! @Returns a morphism $Q_A \to A$
DeclareAttribute( "RetractionOfMorphismToColiftingObject", IsCapCategoryObject );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddRetractionOfMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );


#! @Description
#!  The arguments are an object $Q_A=\mathrm{ColiftingObject}(A)$, a morphism $\alpha:A \to B$ and an object $Q_B=\mathrm{ColiftingObject}(B)$.
#!  The output is a morphism $Q_{\alpha}:Q_A \to Q_B$ with $\comp{q_A}{Q_\alpha} \sim \comp{\alpha}{q_B}$ where $q_A=\mathrm{MorphismToColiftingObject}(A)$
#!  and $q_B=\mathrm{MorphismToColiftingObject}(B)$.
#! @Arguments Q_A, alpha, Q_B
#! @Returns a morphism $Q_A \to Q_B$
DeclareOperation( "ColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategoryObject, IsCapCategoryMorphism, IsCapCategoryObject ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddColiftingMorphismWithGivenColiftingObjects",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha : A \to B$.
#!  The output is a morphism $Q_{\alpha}:Q_A \to Q_B$ with $\comp{q_A}{Q_\alpha} \sim \comp{\alpha}{q_B}$ where
#!  $Q_A=\mathrm{ColiftingObject}(A)$, $Q_B=\mathrm{ColiftingObject}(B)$, $q_A=\mathrm{MorphismToColiftingObject}(A)$ and
#!  $q_B=\mathrm{MorphismToColiftingObject}(B)$.
#! @Arguments alpha
#! @Returns a morphism $Q_A \to Q_B$
DeclareAttribute( "ColiftingMorphism", IsCapCategoryMorphism );

#! @Description
#!  The argument is a morphism $\alpha:A \to B$.
#!  The output is whether or not $\alpha$ colifts along $q_A: A \to Q_A$ where
#!  $q_A=\mathrm{MorphismToColiftingObject}(A)$.
#! @Arguments alpha
DeclareProperty( "IsColiftableAlongMorphismToColiftingObject",
                  IsCapCategoryMorphism );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddIsColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Description
#!  The argument is a morphism $\alpha:A \to B$ which colifts along $q_A:A \to Q_A$, where $q_A=\mathrm{MorphismToColiftingObject}(A)$.
#!  The output is a colift morphism $\lambda:Q_A \to B$ of $\alpha$ along $q_A$, i.e., $\comp{q_A}{\lambda} \sim \alpha$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[r, "\alpha"] \arrow[d, "q_A"'] & B \\
#! \phantom{.}Q_A. \arrow[ru, "\lambda"']              &  
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! @Arguments alpha
#! @Returns a morphism $\lambda:A \to L_B$
DeclareAttribute( "WitnessForBeingColiftableAlongMorphismToColiftingObject", IsCapCategoryMorphism );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsFunction, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList, IsInt ] );

DeclareOperation( "AddWitnessForBeingColiftableAlongMorphismToColiftingObject",
                  [ IsCapCategory, IsList ] );

#! @Section Examples for systems of colifting objects

#! @Subsection The class of E-injective objects in exact categories with enough E-injectives
#!  
#!  Let $(\CC,\EE)$ is an exact category with enough $\EE$-injective objects. That is, for any object $A$, there exists an inflation $\iota_A:A \to I_A$ into some $\EE$-injective object $I_A$.
#!  We define $\QQ$ by the class of all $\EE$-injective objects in $\CC$.
#!  For an object $A$ in $\CC$, we define the the distinguished object $Q_A$ by $I_A$ and the distinguished morphism $q_A:A\to Q_A$ by $\iota_A:A \to I_A$.
#!  If $A$ happens to be an $\EE$-injective object, then $q_A$ is a split-monomorphism and its retraction morphism $r_A:Q_A \to A$ is given by the $\EE$-injective colift
#!  of $\id_A$ along the inflation $q_A$.
#!  For a morphism $\alpha: A \to B$, we define $Q_\alpha:Q_A\to Q_B$ by the $\EE$-injective colift of $\comp{\alpha}{q_B}$ along the inflation $q_A$.
#!
#!  For instance, the class of all injective objects in an abelian category with enough injective objects defines a system of colifting objects. 
#!  @LatexOnly See Section \ref{Section_efsolo} for further details.

#! @InsertChunk freyd_categories_graded_exterior_algebra-colifting-system

#! @Subsection The class of all objects in arrows categories represented by split-epimorphisms
#!
#! Let $\CC$ be an additive category and $\mathrm{Arr}(\CC)$ its category of arrows, i.e.,
#! its objects are morphisms in $\CC$ and its morphisms are commutative squars in $\CC$.
#! The class $\QQ$ of all objects in $\mathrm{Arr}(\CC)$ that are represented by split-epimorphisms defines a system of colifting objects in $\mathrm{Arr}(\CC)$.
#! For an object $A=(\alpha:A_1 \to A_2)$ in $\mathrm{Arr}(\CC)$, we define $Q_A$ by
#! @LatexOnly $\bigl(\bigl(\begin{smallmatrix} \alpha \\ \id_{A_2}\end{smallmatrix}\bigr): A_1 \oplus A_2 \to A_2\bigr)$
#! and $q_A: A \to Q_A$ by the commutative square whose legs are
#! @LatexOnly $\bigl(\begin{smallmatrix} \id_{A_1} & 0\end{smallmatrix}\bigr): A_1 \to A_1 \oplus A_2$
#! and $\id_{A_2}:A_2 \to A_2$.
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! A \arrow[d, "q_A"] \& A_1 \arrow[r, "\alpha"] \arrow[d, "{\bigl(\begin{smallmatrix}\mathrm{id}_{A_1} & 0 \end{smallmatrix}\bigr)}"', hook] \& A_2 \arrow[d, "\mathrm{id}_{A_2}", hook] \\
#! Q_A                \& A_1 \oplus A_2 \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"']          \& \phantom{.}A_2.
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#!
#! If $A$ belong to $\QQ$, then $\alpha:A_1 \to A_2$ is a split-epimorphism and it has a section morphism is $\gamma: A_2 \to A_1$. In this case $q_A$ is a split-monomorphism and its retraction morphism is given by the commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! A                    \& A_1 \arrow[r, "\alpha"]                                                                                                                                                                                 \& A_2                                 \\
#! Q_A \arrow[u, "r_A"] \& A_1 \oplus A_2 \arrow[u, "{\bigl(\begin{smallmatrix}\mathrm{id}_{A_1} \\ \gamma \end{smallmatrix}\bigr)}"] \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"'] \& \phantom{.}A_2. \arrow[u, "\mathrm{id}_{A_2}"']
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly

#! Let $B=(\beta:B_1 \to B_2)$ be an object in $\mathrm{Arr}(\CC)$ and $\varphi: A \to B$ be a morphism defined by a commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}
#! A \arrow[d, "\varphi"'] & A_1 \arrow[r, "\alpha"] \arrow[d, "\varphi_1"'] & A_2 \arrow[d, "\varphi_2"] \\
#! B                       & B_1 \arrow[r, "\beta"']                         & B_2. 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#! We define $Q_{\varphi}: Q_A \to Q_B$ by the commutative square
#! @BeginLatexOnly
#! \begin{center}
#! \begin{tikzcd}[ampersand replacement=\&]
#! Q_A \arrow[d, "Q_\varphi"'] \& A_1 \oplus A_2 \arrow[r, "{\bigl(\begin{smallmatrix}\alpha \\ \mathrm{id}_{A_2} \end{smallmatrix}\bigr)}"] \arrow[d, "{\bigl(\begin{smallmatrix}\varphi_1 & 0 \\ 0 & \varphi_2 \end{smallmatrix}\bigr)}"'] \& A_2 \arrow[d, "\varphi_2"] \\
#! Q_B                         \& B_1 \oplus B_2 \arrow[r, "{\bigl(\begin{smallmatrix}\beta \\ \mathrm{id}_{B_2} \end{smallmatrix}\bigr)}"']                                                                                                 \& \phantom{.}B_2                      . 
#! \end{tikzcd}
#! \end{center}
#! @EndLatexOnly
#!

#! The arrows category $\mathrm{Arr}(\CC)$ is isomorphic to the category of functors $\mathrm{Hom}(1\to 2,\CC)$, where $1 \to 2$ is the interval category which is the $\mathbb{Z}$-linear
#! closure of the quiver consisting of two vertices $v_1,v_2$ and an arrow $m:v_1\to v_2$.

#!
#! The following function takes and additive category $\CC$ and constructs its arrows category $\mathrm{Arr}(\CC)$ and equipps it with the above system of colifting objects.
#! It requires the &GAP; package
#! @LatexOnly \cite[FunctorCategories]{FunctorCategories2021.05-01}.
#!
#! @InsertChunk category_of_arrows_method
#! @InsertChunk category_of_arrows_of_additive_closure_of_algeboid

#! @Chapter Stable Categories
#! @Section GAP categories

#! @Description
#! The &GAP; category of stable categories
#! @Arguments seq_obj
DeclareCategory( "IsStableCategory",
                 IsQuotientCategory );

#! @Description
#! The &GAP; category of stable categories cells.
#! @Arguments seq_obj
DeclareCategory( "IsStableCategoryCell",
                 IsQuotientCategoryCell );

#! @Description
#! The &GAP; category of stable categories objects.
#! @Arguments seq_obj
DeclareCategory( "IsStableCategoryObject",
                 IsStableCategoryCell and IsQuotientCategoryObject );

#! @Description
#! The &GAP; category of stable categories morphisms.
#! @Arguments seq_obj
DeclareCategory( "IsStableCategoryMorphism",
                 IsStableCategoryCell and IsQuotientCategoryMorphism );

#! @Section Constructors


#! @Description
#!  The arguments are an additive category $\CC$ and a function $f$ which decides whether or a not a morphism $\alpha:A \to B$ in $\CC$ belongs to some two-sided ideal $I$
#!  of morphisms in $\CC$. The output is the stable category $\CC/I$.
#! @Arguments category, f
#! @Returns an additive category $\CC/I$
DeclareOperation( "StableCategory",
            [ IsCapCategory, IsFunction ] );

#! @Description
#!  The argument is a stable category $\CC/I$.
#!  The output is is a gap function $f$ such that for any $\alpha$ in $\CC$,
#!  $[\alpha] \sim 0$ if and only if $f(\alpha)=\mathrm{true}$.
#! @Arguments stable_category
#! @Returns a gap function
DeclareAttribute( "CongruencyTestFunction", IsStableCategory );

#! @Description
#!  The argument is a stable category $\CC/I$.
#!  The output is the natural projection functor $\pi: \CC \to \CC/I$.
#! @Arguments stable_category
#! @Returns a functor $\CC \to \CC/I$
DeclareAttribute( "ProjectionFunctor", IsStableCategory );

#! @Description
#!  The arguments are a stable category $\CC/I$ and an object $A$ in $\CC$.
#!  The output is $[A]$ in $\CC/I$.
#! @Arguments stable_category, A
#! @Returns $[A]$ in $\CC/I$
DeclareOperation( "StableCategoryObject",
            [ IsStableCategory, IsCapCategoryObject ] );

if false then
#! @Description
#!  The argument is an object $[A]$ in a stable category $\CC/I$.
#!  The output is $A$.
#! @Arguments class_A
#! @Returns an object in $\CC$
DeclareAttribute( UnderlyingCell, IsStableCategoryObject );
fi;

#! @Description
#!  The arguments are an object $[A]$ in a stable category $\CC/I$, a morphism $\alpha:A\to B$ in $\CC$ and an object $[B]$ in $\CC/I$.
#!  The output is $[\alpha]$ in $\CC/I$.
#! @Arguments class_A, alpha, class_B
#! @Returns $[\alpha]:[A]\to [B]$ in $\CC/I$
DeclareOperation( "StableCategoryMorphism",
            [ IsStableCategoryObject, IsCapCategoryMorphism, IsStableCategoryObject ] );

#! @Description
#!  The arguments are a stable category $\CC/I$ and a morphism $\alpha:A\to B$ in $\CC$.
#!  The output is $[\alpha]$ in $\CC/I$.
#! @Arguments alpha
#! @Returns $[\alpha]:[A]\to [B]$ in $\CC/I$
DeclareOperation( "StableCategoryMorphism",
            [ IsStableCategory, IsCapCategoryMorphism ] );

if false then
#! @Description
#!  The argument is a morphism $[\alpha]$ in a stable category $\CC/I$.
#!  The output is $\alpha$.
#! @Arguments class_alpha
#! @Returns an object in $\CC$
DeclareAttribute( UnderlyingCell, IsStableCategoryMorphism );
fi;


#! @Section Example for a stable category
#! @InsertChunk stable_cat_by_projectives

#! @Section Stable categories defined by systems of lifting objects

#!  
#!  Let $\CC$ be a category equipped with a system $\LL$ of lifting objects.
#!  The set of all morphisms $\alpha:A \to B$ which lift along $\ell_B:L_B \to B$ defines a two-sided ideal $I_{\LL}$ of morphisms in $\CC$.
#!  It can be shown that a morphism $\alpha: A \to B$ belongs to $I_{\LL}$ if and only if it factors through at least on object in $\LL$.
#!  The extra structure which is bundled with the system of lifting objects enables us to lift more than additive structure form $\CC$ to $\CC/I_{\LL}$.
#!  This will be illustrated in the next example. The category $\CC/{I_{\LL}}$ can be constructed by the following operation:

#! @Description
#!  The argument is an additive category equipped with a system of lifting objects $\LL$.
#!  The output is the stable category $\CC/I_{\LL}$ where $I_{\LL}$ is the two-sided ideal of morphisms $\alpha: A \to B$ in $\CC$ that lift along $\ell_B:L_B \to B$.
#! @Arguments category
#! @Returns a stable category
DeclareAttribute( "StableCategoryBySystemOfLiftingObjects", IsCapCategory );

#! @InsertChunk stable_cat_by_projectives_as_lifting_objects

#! @Section Stable categories defined by systems of colifting objects
#!  
#!  Let $\CC$ be a category equipped with a system $\QQ$ of colifting objects.
#!  The set of all morphisms $\alpha:A \to B$ which colift along $q_A:A \to Q_A$ defines a two-sided ideal $I_{\QQ}$ of morphisms in $\CC$.
#!  It can be shown that a morphism $\alpha: A \to B$ belongs to $I_{\QQ}$ if and only if it factors through at least on object in $\QQ$.
#!  The extra structure which is bundled with the system of colifting objects enables us to lift more than additive structure form $\CC$ to $\CC/I_{\LL}$.
#!  The category $\CC/{I_{\QQ}}$ can be constructed by the following operation:

#! @Description
#!  The argument is an additive category equipped with a system of colifting objects $\QQ$.
#!  The output is the stable category $\CC/I_{\QQ}$ where $I_{\QQ}$ is the two-sided ideal of morphisms $\alpha: A \to B$ in $\CC$ that colift along $q_A:A \to Q_A$.
#! @Arguments category
#! @Returns a stable category
DeclareAttribute( "StableCategoryBySystemOfColiftingObjects", IsCapCategory );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE_WITH_ABELIAN_RANGE_CAT" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_COLIFTING_STRUCTURE" );

DeclareGlobalFunction( "ADD_HOMOMORPHISM_STRUCTURE_TO_STABLE_CATEGORY_BY_LIFTING_STRUCTURE" );

DeclareGlobalVariable( "CAP_INTERNAL_STABLE_CATEGORIES_BASIC_OPERATIONS" );

DeclareGlobalVariable( "STABLE_CATEGORIES_METHOD_NAME_RECORD" );

DeclareOperation( "HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_COLIFTING_OBJECTS", [ IsStableCategoryObject, IsStableCategoryObject ] );

DeclareOperation( "HOMOMORPHISM_STRUCTURE_ON_STABLE_OBJECTS_BY_LIFTING_OBJECTS", [ IsStableCategoryObject, IsStableCategoryObject ] );
