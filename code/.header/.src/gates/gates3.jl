
#Defining the Basic Logic Gates

#NOTE: Here they are already the spin gates not Pauli

#The X,Y,Z gates:

# Spin-1 Pauli analogues
X = (1/sqrt(2)) * [
    0  1  0
    1  0  1
    0  1  0
] .+ 0im  # ensure complex type

Y = (1/sqrt(2)) * [
    0   -im   0
    im   0   -im
    0    im   0
]

Z = [
    1  0  0
    0  0  0
    0  0 -1
] .+ 0im


function RX(r)
    exp(-1im * r * X)
end

function RY(r)
    exp(-1im * r * Y)
end

function RZ(r)
    exp(-1im * r * Z)
end


# Version 1: Fourier transform (common qutrit Hadamard)
ω = cis(2π/3)  # exp(i*2π/3)
H_fourier = (1/sqrt(3)) * [
    1     1     1
    1     ω     ω^2
    1     ω^2   ω
]

H_spin = exp(1im * (π/2) * Y)


# Qutrit CNOT = Controlled-SUM gate (9x9)
function qutrit_cnot()
    U = zeros(ComplexF64, 9, 9)
    for c in 0:2, t in 0:2
        input_index  = 3*c + t + 1
        output_index = 3*c + ((t + c) % 3) + 1
        U[output_index, input_index] = 1
    end
    return U
end

CNOT = qutrit_cnot()

;