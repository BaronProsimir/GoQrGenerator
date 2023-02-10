---
Locale: en-US
Title: Export-QrCode
---

# Export-QrCode

## SYNOPSIS

Exports parameterized Qr Code to a file.

## SYNTAX

### Export (Default)

```
Export-QrCode [-Path] <String> [-Body] <String[]> [[-FileName] <String>] [[-Size] <Int16>] [[-CharsetSource] <String>] 
[[-Color] <String>] [[-BgColor] <String>] [[-Margin] <Int16>] [[-QZone] <Int16>] [[-Format] <String>] [<CommonParameters>]
```

## DESCRIPTION

The `Export-QrCode` function generates [GoQr.me](https://goqr.me) API URL, sends [GET request](https://reqbin.com/Article/HttpGet) towards it and downloads the generated [QR code](https://en.wikipedia.org/wiki/QR_code) image into a choosed [path.](#-path)

## EXAMPLES

### Example 1: Downloads a default Qr Code

```powershell
Export-QrCode -Path "C:\QrCodes\" -Body "NazdarSvet!"
```

This command downloads a Qr code with "NazdarSvet!" text into a 'C:\QrCodes\' folder.
> ***NOTE:*** Folder has to exists!

### Example 2: Download an advanced Qr Code

```powershell
Export-QrCode -Path "C:\QrCodes" -Body "https://www.google.com/search?q=baronprosimir" -FileName "WhoIsBaronProsimir" -Size 300 -Color 9-97-153 -BgColor 230-147-34  -Margin 5 -QZone 2 -Format svg
```
This command downolads a QR code which contains Google search of the "BaronProsimir" text url  
with size of 300px, blue data color and orange background, 5px margin and 2px quiet-zone on SVG format.

## PARAMETERS

### -Path

A required parameter that specifies the location to save the QR code file.

```yaml
Type: System.String
Parameter Sets: Default
Aliases:
Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Body

The text to store within the QR code/s.

If one string is passed, only one QR code will be generated without count.  
If more strings are passed, the count on the end of the **FileName** will be added. ( Starting with 0! ):

QrCode0, QrCode1, QrCode2 etc.

```yaml
Type: System.String[]
Parameter Sets: Default
Aliases:
Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName

 The name of the downloaded QR code file/s.

```yaml
Type: System.String
Parameter Sets: Definition
Aliases:
Required: False
Position: 3
Default value: QrCode
Accept pipeline input: False
Accept wildcard characters: False
```

### -Size

Specifies a size of the QR code image/s you want to generate:
- In PIXELS for raster graphic formats like PNG, GIF or JPEG.
- As LOGICAL UNIT for vector graphics (SVG, EPS).

```yaml
Type: System.Int16
Parameter Sets: 
Aliases: 
Required: False
Position: 4
Default value: 200
Accept pipeline input: False
Accept wildcard characters: False
```

### -CharsetSource

Specifies the charset the text submitted via data parameter is encoded in.

```yaml
Type: System.String
Parameter Sets: Definition
Aliases:
Required: False
Position: 5
Default value: UTF-8
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color

The data color of the final QR code.  
[ValidatePattern("[0-256]-[0-256]-[0-256]")]

```yaml
Type: System.String
Parameter Sets: Definition
Aliases:
Required: False
Position: 6
Default value: 0-0-0
Accept pipeline input: False
Accept wildcard characters: False
```

### -BgColor

The background color of the final QR code.  
[ValidatePattern("[0-256]-[0-256]-[0-256]")]

```yaml
Type: System.String
Parameter Sets: Definition
Aliases:
Required: False
Position: 7
Default value: 255-255-255
Accept pipeline input: False
Accept wildcard characters: False
```

### -Margin

Thickness of a margin in a PIXELS.

Minimum value: 0  
Maximum value: 50  
Default value: 1  

```yaml
Type: System.Int16
Parameter Sets: Definition
Aliases:
Required: False
Position: 8
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -QZone

Thickness of a "quiet zone" ( An area without disturbing elements to help  
readers locating the QR code), in modules as measuring unit.

```yaml
Type: System.Int16
Parameter Sets: Definition
Aliases:
Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Format

It is possible to create the QR code picture using different file formats,  
available are PNG, GIF, JPEG and the vector graphic formats SVG and EPS.

```yaml
Type: System.String
Parameter Sets: Definition
Aliases:
Required: False
Position: 10
Default value: png
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable,  
-InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose,  
-WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe a strings containg a path and a body ( bodies ) of QR code/s to this function.

## OUTPUTS

### System.Drawing.Bitmap

This function returns an object/s which shares choosed **Format**.

## NOTES

Version: 1.0.0  
[(C) BaronProsimir 2022](https://www.linkedin.com/in/roman-vaňo-08697318a/, "My LinkedIn profile.")

## RELATED LINKS

You can find an Original [goqr.me](https://goqr.me) API documentation [here..](https://goqr.me/api/doc/create-qr-code)  
.. and Github repository over [here,](https://github.com/BaronProsimir/GoQrGenerator)