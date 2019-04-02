<#
    .SYNOPSIS
        Decimal/Binary Conversion Functions
    .DESCRIPTION
        The two functions convert values between decimal (int type) and binary (as a string)
#>


function Convert-DecToBinOctet ([int]$dec){
    ## ensure that $dec is between 0 and 255
    if ($dec -le 255 -and $dec -ge 0){
        $octet = ''
        ## generate binary value for integer value as a string, return
        ## test each 2^e if larger than #dec. if larger, append a 1 and subtract the value from $dec; if smaller, append a 0
        foreach ($e in (7..0)){
            if ($dec -ge ([System.Math]::Pow(2,$e))){
                $octet += '1'
                $dec -= ([System.Math]::Pow(2,$e))
            } else {
                $octet += '0'
            }
        }    
    } else {
        return -1
        break
    }
    return $octet
}

function Convert-BinOctetToDec ([string]$octet){
    <#
    Ensure that:
        1. The string only contains ones and zeroes
        2. The string is exactly 8 characters in length (this afterall, should be an octet, not a random binary number of
        a dynamic len)
    #> 
    if ($octet -match '[2-9A-Za-z]'){
        return -1
    } elseif ($octet.Length -ne 8){
        return -2
    } else {
        try{
            $i = 0
            $dec = 0
            foreach ($e in (7..0)){
                if ($octet[$i] -eq '1'){
                    $dec += [System.Math]::Pow(2,$e)
                }
                $i++
            }
            if ($dec -gt 255){
                return -4
            } else {
                return $dec
            }
        } catch {
            return -3
        }
    }
}
