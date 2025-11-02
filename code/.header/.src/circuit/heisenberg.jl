

#################################
# Dependencies
#################################

include("brickwall.jl")





######################
# This code generates Unitary Brickwall circuit corresponding to the heisenberg model;
# Form: H = J ZZ +  θ/2 (XX+YY) + h Z
# h is always disordered and uniformly sampled from [0, 2pi] 
#
# J has two options: One can use a uniform J=Jmean or sample J uniformly from [0, pi]
# (See ###Coefficient of ZZ)
#
# Jmean is traded as in input for J, the Multiple Dispatch wrappers automatically 
# takes care of including the correct Coefficient. 
#
#
# options for including various noise models is coded and commented out
#
# The Skeleton function
#######################


function circuit_heisenberg(L::Int, thetamean::Float64, h::Array{Float64}, J::Array{Float64})
  
    
###########################################    
# Defining the indices
###########################################

        Ind=collect(1:L)
 #########################################
 # Background Disorder for the Z field
 #########################################
        ZRow=RZ.(h);


 ###########################################
 #Constructing the Random Brickwall 
 ###########################################

        #Coefficient of ZZ        
        
        #J=rand(L)*pi;                           #Ising Even Disorder on the two body gates
        #J=fill(Jmean, L);                       #Fixed strength on ZZ
        
        

        #thetadev=pi/50;
        theta=thetamean #+randn(1)[]*thetadev;  #Interaction (Noise not included)
        
        #For the two body XX+YY gates:

        fonez=copy(kron(Z,Z))
        ftwox=copy(kron(X,X));                  
        ftwoy=copy(kron(Y,Y));

        #############################################
        # Defining two body gates as array of Tensors        
        ##############################################
  
        FU=fill(fill(0.0*im, 4,4), L-1);
  
        for i in 1:L-1

                #delh=randn(4)*pi/50;                                   #Imperfection in Z tuning not included
                #int1=kron(RZ(delh[1]),RZ(delh[2]));
                #int2=exp(-im*J*fonez-im*theta/2*(ftwox+ftwoy));
                int2=exp(-im*J[i]*fonez-im*theta/2*(ftwox+ftwoy));
                #int3=kron(RZ(delh[3]),RZ(delh[4]));

                FU[i]=int2;

        end


        #############################################
        # Local Background Field      
        ##############################################


        for i in 1:2:L-1
                FU[i]=FU[i]*kron(ZRow[i],ZRow[i+1]);
        end





    A=brickwall(FU)   # Construct the matrix using brickwall function
    
    #return FU
    return A

end
;


################################
# Multiple Dispatch variations:
#################################


# implicitly drawing Disorder

function circuit_heisenberg(L::Int, thetamean::Float64, J::Array{Float64})
 
 
        # Background Disorder for the Z field
 
        h=rand(L)*2*pi;
        

        A=circuit_heisenberg(L, thetamean, h, J)
        return A
end

# J=1, explicitly drawing Disorder






# implicitly drawing Disorder, J=1


function circuit_heisenberg(L::Int, thetamean::Float64)
        
        J=rand(L-1)*pi;   
        h=rand(L)*2*pi;
        

        A=circuit_heisenberg(L, thetamean, h, J)
        return A
end
  