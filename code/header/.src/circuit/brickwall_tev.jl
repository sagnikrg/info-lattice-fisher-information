
using ITensors
ITensors.disable_warn_order()


#################################
# Dependencies
#################################


include("time-crystals.jl")


##################################
# Note in this case the order of the gates in brick has changed.
# Unlike tev_1 case we first put all the odd gates and then the even gates.
# This has to be accounted appropriately in the tev function.
##################################


########################################################

# The Brickwall as a Tensor Function
# format

# |     |     |     |     |     |     |     |  
#---------------------------------------------
#       |  2  |     |  4  |     |  6  |         
#---------------------------------------------
# |  1  |     |  3  |     |  5  |     |  7  |
#---------------------------------------------
# |     |     |     |     |     |     |     |

########################################################




    
function itensorise(FUTensor, sites, dummysites)
    L=length(FUTensor);
    gates = ITensor[]
    for i in 1:2:L
        push!(gates, ITensor(FUTensor[i],dummysites[i+1],dummysites[i],sites[i+1],sites[i]))
    end
  

    for i in 2:2:L
        push!(gates, ITensor(FUTensor[i],sites[i+1],sites[i],dummysites[i+1],dummysites[i]))
        end
  
    gates
end

########################################
# time evolution with ITensor
########################################


function brickwall_tev(Psi, brick, sites, dummysites)

    L=length(brick)
    Lhalf=Int((L+1)/2)
    for i in 1:Lhalf
        Psi=brick[i]*Psi
    end

    #for i in 1:L+1
    #    Psi=Psi*delta(sites[i],dummysites[i])
    #end

    #order_dummy = (dummysites[1],dummysites[2],dummysites[3],dummysites[4],dummysites[5],dummysites[6],dummysites[7],dummysites[8])
    #Psi=permute(Psi, order_dummy)

    for i in (Lhalf+1):L
        Psi=brick[i]*Psi
    end
    
    #for i in 2:L
        Psi=Psi*delta(sites[1],dummysites[1])
        Psi=Psi*delta(sites[L+1],dummysites[L+1])
    #end
    
    #order = (sites[8],sites[7],sites[6],sites[5],sites[4],sites[3],sites[2],sites[1])
    #Psi=permute(Psi, order)
   
    # psi=apply(brick[1:2:L-1], psi);  # Apply the odd gates
   # psi=apply(brick[2:2:L-1], psi);  # Apply the even gates
    Psi
end





