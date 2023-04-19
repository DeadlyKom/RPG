
                ifndef _STRUCT_BASE_
                define _STRUCT_BASE_

                struct FValue
Low             DB #00
High            DB #00
                ends

                struct FAddress
Low             DB #00
High            DB #00
                ends

                struct FSize
Width           DB #00
Height          DB #00
                ends

                struct FOffset
X               DB #00
Y               DB #00
                ends

                 struct FLocation
X               DB #00
Y               DB #00
                ends

                struct FVector16
Y               FValue															; для сортировки первый Y
X               FValue
                ends

                struct FLocation16
X               FValue
Y               FValue															; для сортировки первый Y
                ends

                struct FFlags
                DB #00
                ends

                struct FWFlags
Data			FValue
                ends

                struct FPNInt32
.Low            FValue
.High           FValue
                ends

                struct FLocation32
.X              FPNInt32
.Y              FPNInt32
                ends

                struct FPNInt40
.Byte           DB #00
.Int            FPNInt32
                ends

                struct FLocation40
.X              FPNInt40
.Y              FPNInt40
                ends

                struct FNoise2D
.Frequency      DB #00
.Location       FLocation32
                ends

                endif ; ~_STRUCT_BASE_
