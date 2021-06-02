




#! @Chunk category_of_arrows_method
#! 
#! @BeginLatexOnly
#!\begin{Verbatim}[commandchars=!?|,fontsize=\small,frame=single,label=Code]
#!  LoadPackage!cbracket?(| !cstring?"FunctorCategories"| !cbracket?)|;
#!  LoadPackage!cbracket?(| !cstring?"StableCategories"| !cbracket?)|;
#!  !gapinput?|
#!  DeclareAttribute!cbracket?(| !cstring?"CategoryOfArrows"|!cbracket?,| IsCapCategory !cbracket?)|;
#!  !gapinput?| 
#!  InstallMethod!cbracket?(| CategoryOfArrows!cbracket?,|
#!            !cbracket?[| IsCapCategory !cbracket?]|!cbracket?,|
#!     !gapinput?| 
#!     !ckey?function|!cbracket?(| C !cbracket?)|
#!       !ckey?local| quiver!cbracket?,| ring!cbracket?,| algebra!cbracket?,| over_Z!cbracket?,| algebroid!cbracket?,| arrows;
#!     !gapinput?|        
#!       quiver !cequality?:=| RightQuiver!cbracket?(| !cstring?"q(1,2)[m:1->2]"| !cbracket?)|;
#!    !gapinput?|        
#!       ring !cequality?:=| CommutativeRingOfLinearCategory!cbracket?(| C !cbracket?)|;
#!    !gapinput?|        
#!       !ckey?if| HasIsFieldForHomalg!cbracket?(| ring !cbracket?)| and IsFieldForHomalg!cbracket?(| ring !cbracket?)| then
#!    !gapinput?|            
#!         algebra !cequality?:=| PathAlgebra!cbracket?(| ring!cbracket?,| quiver !cbracket?)|;
#!    !gapinput?|            
#!         over_Z !cequality?:=| false;
#!    !gapinput?|            
#!       !ckey?else|
#!    !gapinput?|            
#!         algebra !cequality?:=| PathAlgebra!cbracket?(| HomalgFieldOfRationals!cbracket?(| !cbracket?)|!cbracket?,| quiver !cbracket?)|;
#!    !gapinput?|            
#!         over_Z !cequality?:=| true;
#!    !gapinput?|            
#!       !ckey?fi|;
#!    !gapinput?|            
#!       algebroid !cequality?:=| Algebroid!cbracket?(| algebra!cbracket?,| over_Z !cbracket?)|;
#!    !gapinput?|            
#!       arrows !cequality?:=| Hom!cbracket?(| algebroid!cbracket?,| C : FinalizeCategory !cequality?:=| false !cbracket?)|;
#!    !gapinput?|            
#!       ## Defining the system of colifting objects
#!    !gapinput?|    
#!       AddIsColiftingObject!cbracket?(| arrows!cbracket?,|
#!           { category!cbracket?,| A } -> IsSplitEpimorphism!cbracket?(| A!cbracket?(| algebroid.m !cbracket?)| !cbracket?)|
#!       !cbracket?)|;
#!    !gapinput?|    
#!       ##
#!       AddColiftingObject!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| A !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| QA_1!cbracket?,| QA_2!cbracket?,| A_m!cbracket?,| QA_m;
#!    !gapinput?|                    
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!    !gapinput?|                    
#!           QA_1 !cequality?:=| DirectSum!cbracket?(| A_1!cbracket?,| A_2 !cbracket?)|;
#!           QA_2 !cequality?:=| A_2;
#!    !gapinput?|                    
#!           A_m !cequality?:=| A!cbracket?(| algebroid.m !cbracket?)|;
#!    !gapinput?|            
#!           QA_m !cequality?:=| !cbracket?[|
#!                     MorphismBetweenDirectSums!cbracket?(|
#!                         !cbracket?[|
#!                             !cbracket?[| A_m !cbracket?]|!cbracket?,|
#!                             !cbracket?[| IdentityMorphism!cbracket?(| A_2 !cbracket?)| !cbracket?]|
#!                         !cbracket?]|
#!                      !cbracket?)|
#!                   !cbracket?]|;
#!    !gapinput?|                    
#!           !ckey?return| AsObjectInHomCategory!cbracket?(| algebroid!cbracket?,| !cbracket?[| QA_1!cbracket?,| QA_2 !cbracket?]|!cbracket?,| QA_m !cbracket?)|;
#!    !gapinput?|
#!         !ckey?end| !cbracket?)|;
#!    !gapinput?|    
#!        ##
#!       AddMorphismToColiftingObjectWithGivenColiftingObject!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| A!cbracket?,| QA !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| qA_1!cbracket?,| qA_2;
#!   !gapinput?|                    
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!   !gapinput?|                    
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!   !gapinput?|                    
#!           qA_1 !cequality?:=| MorphismBetweenDirectSums!cbracket?(|
#!                        !cbracket?[|
#!                            !cbracket?[| IdentityMorphism!cbracket?(| A_1 !cbracket?)|!cbracket?,| ZeroMorphism!cbracket?(| A_1!cbracket?,| A_2 !cbracket?)| !cbracket?]|
#!                        !cbracket?]|
#!                    !cbracket?)|;
#!   !gapinput?|                    
#!           qA_2 !cequality?:=| IdentityMorphism!cbracket?(| A_2 !cbracket?)|;
#!   !gapinput?|            
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| A!cbracket?,| !cbracket?[| qA_1!cbracket?,| qA_2 !cbracket?]|!cbracket?,| QA !cbracket?)|;
#!   !gapinput?|            
#!         !ckey?end| !cbracket?)|;
#!   !gapinput?|
#!       ##
#!       AddRetractionOfMorphismToColiftingObjectWithGivenColiftingObject!cbracket?(| arrows,
#!         !ckey?function|!cbracket?(| category!cbracket?,| A!cbracket?,| QA !cbracket?)|
#!           !ckey?local| A_1!cbracket?,| A_2!cbracket?,| alpha!cbracket?,| gamma!cbracket?,| rA_1!cbracket?,| rA_2;
#!          !gapinput?| 
#!           A_1 !cequality?:=| A!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!           !gapinput?|
#!           A_2 !cequality?:=| A!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!           !gapinput?|
#!           alpha !cequality?:=| A!cbracket?(| algebroid.m !cbracket?)|;
#!           !gapinput?|
#!           gamma !cequality?:=| SectionForMorphisms!cbracket?(| alpha !cbracket?)|;
#!           !gapinput?|
#!           rA_1 !cequality?:=| MorphismBetweenDirectSums(
#!                     !cbracket?[|
#!                       !cbracket?[| IdentityMorphism!cbracket?(| A_1 !cbracket?)| !cbracket?]|!cbracket?,|
#!                       !cbracket?[| gamma !cbracket?]|
#!                     !cbracket?]|
#!                   !cbracket?)|;
#!           !gapinput?|
#!           rA_2 !cequality?:=| IdentityMorphism!cbracket?(| A_2 !cbracket?)|;
#!           !gapinput?|
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| QA!cbracket?,| !cbracket?[| rA_1!cbracket?,| rA_2 !cbracket?]|!cbracket?,| A !cbracket?)|;
#!           !gapinput?|
#!         !ckey?end| );
#! !gapinput?|
#!       ##
#!       AddColiftingMorphismWithGivenColiftingObjects!cbracket?(| arrows!cbracket?,|
#!         !ckey?function|!cbracket?(| category!cbracket?,| QA!cbracket?,| phi!cbracket?,| QB !cbracket?)|
#!           !ckey?local| phi_1!cbracket?,| phi_2!cbracket?,| Qphi_1!cbracket?,| Qphi_2;
#!   !gapinput?|                    
#!           phi_1 !cequality?:=| phi!cbracket?(| algebroid.!cint?1| !cbracket?)|;
#!   !gapinput?|                    
#!           phi_2 !cequality?:=| phi!cbracket?(| algebroid.!cint?2| !cbracket?)|;
#!   !gapinput?|                    
#!           Qphi_1 !cequality?:=| DirectSumFunctorial!cbracket?(| !cbracket?[| phi_1!cbracket?,| phi_2 !cbracket?]| !cbracket?)|;
#!   !gapinput?|                    
#!           Qphi_2 !cequality?:=| phi_2;
#!   !gapinput?|                    
#!           !ckey?return| AsMorphismInHomCategory!cbracket?(| QA!cbracket?,| !cbracket?[| Qphi_1!cbracket?,| Qphi_2 !cbracket?]|!cbracket?,| QB !cbracket?)|;
#!    !gapinput?|
#!         !ckey?end| !cbracket?)|;
#!   !gapinput?|            
#!       Finalize!cbracket?(| arrows !cbracket?)|;
#!   !gapinput?|            
#!       !ckey?return| arrows;
#!   !gapinput?| 
#!     !ckey?end| !cbracket?)|;
#! !gapinput?|
#! DeclareOperation!cbracket?(| !cstring?"CategoryOfArrowsObject"|!cbracket?,|
#!   !cbracket?[| IsCapCategory!cbracket?,| IsCapCategoryMorphism !cbracket?]| !cbracket?)|;
#! !gapinput?|
#! InstallMethod!cbracket?(| CategoryOfArrowsObject!cbracket?,|
#!           !cbracket?[| IsCapCategory!cbracket?,| IsCapCategoryMorphism !cbracket?]|!cbracket?,|
#! !gapinput?|
#!   !ckey?function|!cbracket?(| category!cbracket?,| alpha !cbracket?)|
#!     !ckey?local| 1_m_2;
#! !gapinput?|
#!     1_m_2 !cequality?:=| Source!cbracket?(| category !cbracket?)|;
#! !gapinput?|    
#!     !ckey?return| AsObjectInHomCategory!cbracket?(|
#!                1_m_2!cbracket?,|
#!                !cbracket?[| Source!cbracket?(| alpha !cbracket?)|!cbracket?,| Range!cbracket?(| alpha !cbracket?)| !cbracket?]|!cbracket?,|
#!                !cbracket?[| alpha !cbracket?]|
#!              !cbracket?)|;
#! !gapinput?|
#! !ckey?end| !cbracket?)|;
#! !gapinput?|
#! DeclareOperation!cbracket?(| !cstring?"CategoryOfArrowsMorphism"|!cbracket?,|
#!   !cbracket?[| IsCapCategoryObject!cbracket?,| IsCapCategoryMorphism!cbracket?,|
#!       IsCapCategoryMorphism!cbracket?,| IsCapCategoryObject !cbracket?]| !cbracket?)|;
#! !gapinput?|
#! InstallMethod!cbracket?(| CategoryOfArrowsMorphism!cbracket?,|
#!           !cbracket?[| IsCapCategoryObject!cbracket?,| IsCapCategoryMorphism!cbracket?,|
#!              IsCapCategoryMorphism!cbracket?,| IsCapCategoryObject !cbracket?]|!cbracket?,|
#! !gapinput?|
#!   !ckey?function|!cbracket?(| A!cbracket?,| phi_1!cbracket?,| phi_2!cbracket?,| B !cbracket?)|
#! !gapinput?|    
#!     !ckey?return| AsMorphismInHomCategory!cbracket?(| A!cbracket?,| !cbracket?[| phi_1!cbracket?,| phi_2 !cbracket?]|!cbracket?,| B !cbracket?)|;
#! !gapinput?|
#! !ckey?end| !cbracket?)|;
#! \end{Verbatim}
#! @EndLatexOnly
