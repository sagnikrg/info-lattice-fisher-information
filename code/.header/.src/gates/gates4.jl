
#Defining the Basic Logic Gates



#The X,Y,Z gates:

using LinearAlgebra

# Spin-3/2 matrices (hbar=1)
Z = Diagonal([3/2, 1/2, -1/2, -3/2]) .+ 0im

Sp = [
    0          sqrt(3)   0        0
    0          0         2        0
    0          0         0        sqrt(3)
    0          0         0        0
] .+ 0im

Sm = adjoint(Sp)

X = 0.5 * (Sp + Sm)
Y = 0.5 * (Sp - Sm) / im




# Spin-3/2 rotation gates
function RX(r)
    exp(-1im * r * X)
end

function RY(r)
    exp(-1im * r * Y)
end

function RZ(r)
    exp(-1im * r * Z)
end



# Generalised Hadamard (Fourier on 4 levels)
ω = cis(2π/4)  # = i
H = (1/2) * [
    1   1    1    1
    1   ω   ω^2  ω^3
    1  ω^2   1  ω^2
    1  ω^3  ω^2   ω
]


# Generalised CNOT (Controlled-SUM) for ququart (d=4)
function CNOT_d4()
    U = zeros(ComplexF64, 16, 16)
    for c in 0:3, t in 0:3
        input_index  = 4*c + t + 1
        output_index = 4*c + ((t + c) % 4) + 1
        U[output_index, input_index] = 1
    end
    return U
end

CNOT = CNOT_d4()

;
