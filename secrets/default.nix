#                         _
#  ___  ___  ___ _ __ ___| |_ ___
# / __|/ _ \/ __| '__/ _ \ __/ __|
# \__ \  __/ (__| | |  __/ |_\__ \
# |___/\___|\___|_|  \___|\__|___/
#
#
# Public keys for decrypting Agenix secrets.
let
  jorrit = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCtYfuvWKmjaDK0s+Zu94YKT72QxcekpCueOxduTLCDHmX/gvywzBgwe6Fp9UYAvUwLNQmfcez6o0i4+F2lKMkc+MDtsWR7qVyQ1h0SkZ1ivDdJolA8Nub7JPOjdiNuxkHprj9K68QCFKrA+D6yV9DxSHyXUWXDDhvhyn9t/LxUzC1KhLGcxcGoXhr7gKCswRia32vdAiqe6OmSpSOGnDICIwmQWLL64vlFh6LmRVFEl6NMZD8uzBpTn6n+ZEjIUDymWAtUjvma6ocZ4ry8E+fF5Q39jlK/jefxLhkxyoSEXI06xNwNTAWmprZOVGsjNf9Fuyunvl/Y4W88DDGPEHnBSXpKQvkoUzsw23dgmUTPFA5KrtE7nTspzJFIclquG5HOl23p9ad8tFza85orDxfGO0kubDtuDPXk8UzNz+V2XxsCYoh5JtOk3GKoZeZl8VKlNo+b/1+bLWZwbOLxTgXc8Zc8lXbxdC4oWQCke4KtThg06Jtgy146tlNsa8yk6V0=";
  users = [jorrit];

  lappie = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5bSrSNnQ2yl867cPOCDiRCp7kkDFHKJDDjQYqBECVspK0bZ45huwnfk8LAuE7RY+CfTx1TSLvePC5QmtKC8Q22aV4/pPNOVCGlRPegPRDYATGpx9NN0b02OdN5LSIXPF4/GH+l8gR2Ez0U4EVPnK3lPV9GoLAzQSt/oEqnjsX/HVyUousWr8RztHXjAfEZfSJZKs6nB4fFBMVJ32WDDdVltV1YVGl1mUK0TuqvJwVYnrS68vW4MYHUxsA+J8HF+7GOxxVtogPXwccXScgL/yyM31fUqUfyhDoilr1UThOuyuNrxUF6sgXbN27mfRMscscLBEynARNsjbaRcdSCUU+hOEcnwiEFa4bGuAjopelMpw+gk4RNJjo05kCJxhDuliZg5j+UCdp0WwNqis3NwQON+8o3YZeODCggb7sse8H4muz5r1kSy2g3ht1tIYnQVTNDXTu/d4IkH31wes7QxPU3Y3eXwLnDKLFf0JKepIa9UGQHkclW+f8UpBnDypZmOZGh2QuGZqxeAVHWZP3Q9CW8RbvoMYzXal9y2ImsoN/gk1DdsJEJADfvLs2RzNOH63bsXcJZ+Rbc5JXfXdedE0nTS4daadK8OtOv7W6s05jVldjSJrT1ObwdeBo7r1RH005IW/KtAmZx2Yhppw7XokuOnRFMXzid/V8cYB+sZ8tIQ==";
  hosts = [lappie];
in {
  "jorrit.age".publicKeys = [jorrit lappie];
}
