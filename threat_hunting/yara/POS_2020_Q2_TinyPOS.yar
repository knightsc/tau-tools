rule POS_2020_Q2_TinyPOS_exfil_file : TAU Ecrime POS
{
 meta:
  author = "VMware Carbon Black Threat Research" // jmyers
  date = "2020-May-4"
  Validity = 10
  severity = 10
  description = "For Detection of Exfil Files created by this TinyPOS/PinkKite variant"
  rule_version = 1
  yara_version = "3.11.0"
  Confidence = "Prod"
  Priority = "Medium"
  TLP = "White"
  exemplar_hashes = "e48af0380d51eff554d56aabeeb5087bba37fa8fb02af1ccd155bb8b5079edae"

 strings:
  $b1 = {BD EA 4F 09} //@@@@ header encoded
  $b2 = {20 20 20 20 DD 0A DD 0A} //Delimiter used by malware 
 
 condition:
  all of them
  //Additional Condition configuration
  //$b1 and #b2 > 1
}

rule POS_2020_Q2_TinyPOS_ImageFile_Encoded_SC : TAU Ecrime POS
{
 meta:
  author = "VMware Carbon Black Threat Research" // jmyers
  date = "2020-May-4"
  Validity = 10
  severity = 10
  description = "For Detection of Image files containing encoded Shellcode"
  rule_version = 1
  yara_version = "3.11.0"
  Confidence = "Prod"
  Priority = "Medium"
  TLP = "White"
  exemplar_hashes = "e48af0380d51eff554d56aabeeb5087bba37fa8fb02af1ccd155bb8b5079edae"
 strings:
  $PNG = {89 50 4E 47} //PNG header
  $BMP = {42 4D } //BMP header
  $JPG = {FF D8 FF} //JPG header
  
  $b1 = {48 31 DB 48 C7 C0 [10-20] 90 90 90 90}
  $b2 = {CF CF CF CF}
 
 condition:
  ($PNG at 0
   or $BMP at 0
   or $JPG at 0)
  and all of ($b*)
}

rule POS_2020_Q2_TinyPOS_PS_loader : TAU Ecrime POS
{
 meta:
  author = "VMware Threat Research" // jmyers
  date = "2020-May-4"
  Validity = 10
  severity = 10
  description = "For Detection of PowerShell script used to load TinyPOS/PinkKite"//It should be noted that this will catch numerous malicious PS scripts
  rule_version = 1
  yara_version = "3.11.0"
  Confidence = "Prod"
  Priority = "Medium"
  TLP = "White"
  exemplar_hashes = "15712752daf007ea0db799a318412478c5a3a315a22932655c38ac6485f8ed00"
 strings:
  $ps1 = "powershell"
  $s1 = "IABmAHUAbgBj"
  $s2 = "WwBCAHkAdAB"
 condition:
  $ps1
  and any of ($s*)
}
