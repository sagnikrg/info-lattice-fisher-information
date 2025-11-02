

# dependencies

include("../gates/gates.jl")
include("../functions/kron.jl")


########################################################
# The Brickwall as a Function 
########################################################

# For now we restrict to spin 1/2 systems, i.e. q-dits with level=2
 

function brickwall(FU::Array{Array{ComplexF64,2},1})
        L=length(FU)+1;
        
        Indodd=collect(1:2:L-1);    
        Indeven=collect(2:2:L-1);    
        
        # for even L

        if L%2==0
           

        UOdd=copy(kron_list(FU,Indodd));
        UEven=copy(kron(I(2),kron_list(FU,Indeven),I(2)));
 
        end

        # for odd L

        #if L%2==1
        

        #UOdd=copy(kron(kron_list(FU,Indodd)),I(2));
        #UEven=copy(kron(I(2),kron_list(FU,Indeven)));
        #end
            
        A=UEven*UOdd;   

 A    
end
;



##
#
# i think it is a good idea to check the order of legs of this tensors now
#
##


function brickwall_tensor(FU::Array{Array{ComplexF64,2},1})

FUTensor=fill(fill(0.0*im, 2,2,2,2), length(FU));

for i in 1:length(FU)
      FUTensor[i]=reshape(FU[i],2,2,2,2)
end
 
# Returning Brickwall:        
FUTensor

end
;






function brickwall(L,thetamean,epsilon)
  
    #Constructing the background Z field
    
        h=rand(L)*2*pi;
        Ind=collect(1:L)
        ZRow=copy(kron_list(RZ.(h),Ind));

 
        #Constructing the Random Brickwall 


            J=rand(L)*pi;                     #Ising Even Disorder on the two body gates

            fonez=copy(kron(Z,Z))               #
            ftwox=copy(kron(X,X));              #For the two body XX+YY gates
            ftwoy=copy(kron(Y,Y));              #

    
            thetadev=pi/50;
            theta=thetamean+randn(1)[]*thetadev;               #Interaction (Normal sampling)
                                      
         

      FU=fill(fill(0.0+im, 4,4), L-1);


      for j in 1:length(FU)
           
           
            delh=randn(4)*pi/50;                                          #Site dependent Imperfection in Z tuning (Normal sampling)

                  int1=kron(RZ(delh[1]),RZ(delh[2]));
                  int2=exp(-im*J[j]*fonez-im*theta/2*(ftwox+ftwoy));
                  int3=kron(RZ(delh[3]),RZ(delh[4]));

            FU[j]=int3*int2*int1;
            
      end

        Indodd=collect(1:2:L-1);    
        Indeven=collect(2:2:L-1);    
        
        # for even L

        if L%2==0
           

        UOdd=copy(kron_list(FU,Indodd));
        UEven=copy(kron(I(2),kron_list(FU,Indeven),I(2)));
        end

        # for odd L

        if L%2==1
        
        UOdd=copy(kron(kron_list(FU,Indodd)),I(2));
        UEven=copy(kron(I(2),kron_list(FU,Indeven)));
        end
            


        #Constructing the X Kicks 
 
            g=pi*(1-epsilon);
            XRow=copy(kron_power(RX(g),L));


          A=XRow*UEven*UOdd*ZRow;
          

 A    
end
;