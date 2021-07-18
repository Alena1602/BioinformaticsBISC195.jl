module Assignment07

export normalizeDNA
export composition
export gc_content
export complement
export reverse_complement
export parse_fasta

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
            DNA['A'] += 1
        end
        if key == 'C' 
            DNA['C'] += 1
        end  
        if key == 'G' 
            DNA['G'] += 1
        end 
        if key == 'T' 
            DNA['T'] += 1
        end
        if key == 'N' 
            DNA['N'] += 1
        end
    end
return DNA
end

function gc_content(sequence)
    A,C,G,T,N = composition(sequence)
    return (G + C)/length(sequence)
end

function complement(base::Char)
    complements = Dict("A" => "T",
                       "T" => "A",
                       "G" => "C",
                       "C" => "G",
                       "N" => "N")
    
    base = uppercase(string(base))
    
    !(base in keys(complements)) && error("Invalid base $base")
    return complements[base]
end


function complement(sequence::AbstractString)
    
    sequence = normalizeDNA(sequence)
    complseq = ""
    
    for base in sequence
        complseq = complseq * complement(base)
     end

    return complseq
end

function reverse_complement(sequence)
    
    complseq = complement(sequence)
    revsequence = reverse(complseq)

return revsequence
end

function parse_fasta(path)
    header_list = []
    seq_list = []
    seq = ""
    
    for line in eachline(path)  
        if startswith(line, ">")
            if length(seq) > 0 
                push!(seq_list, seq)
            end
            seq = ""
            push!(header_list, fasta_header(line))
        else 
            seq = seq*line
        end
    end
    push!(seq_list, seq)
    
    header_list = chop.(header_list , head = 1, tail = 0)
    seq_list = normalizeDNA.(seq_list)
    return header_list, seq_list
end
# Don't forget to export your functions!


end # module Assignment07
