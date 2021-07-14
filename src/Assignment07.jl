module Assignment07

export normalizeDNA

# # uncomment the following line if you intend to use BioSequences types
# using BioSequences

"""
    normalizeDNA(::AbstractString)

Ensures that a sequence only contains valid bases
(or `'N'` for unknown bases).
Returns a String.
"""
function normalizeDNA(seq)
    seq = uppercase(string(seq))
    for base in seq
        # note: `N` indicates an unknown base
        occursin(base, "AGCTN") || error("invalid base $base")
    end
    return seq # change to `return LongDNASeq(seq)` if you want to try to use BioSequences types
end

function composition(sequence)
sequence = normalizeDNA(sequence)
DNA = Dict('A'=> 0, 'C'=> 0, 'G'=> 0, 'T'=> 0, 'N'=> 0)
for key in sequence
    if key =='A' 
        DNA['A'] = 0
    end
    if key == 'C' 
        DNA['C'] = 0 
    end  
    if key == 'G' 
        DNA['G'] = 0 
    end 
    if key == 'T' 
        DNA['T'] = 0
    end
    if key == 'N' 
        DNA['N'] = 0
return DNA
end

function gc_content(sequence)
    A,C,G,T,N = composition(sequence)
    return (G + C)/length(sequence)
end

function complement(base)
    complements = Dict("A" => "T",
                       "T" => "A",
                       "G" => "C",
                       "C" => "G"
                       "N" => "N")
    
    base = uppercase(string(base))
    
    !(base in keys(complements)) && error("Invalid base $base")
    return complements[base]
end


function complement(sequence)
    
    sequence = normalizeDNA(sequence)
    complseq = ""
    
        for base in sequence
            return 
            complseq = complseq * complement(base[n])
        end

return complseq
end

function reverse_complement(sequence)
    
    complseq = complement(sequence)
    revsequence = reverse(complseq)

return revsequence
end


# Don't forget to export your functions!


end # module Assignment07
