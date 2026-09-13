# Generates soft-gradient placeholder images for the portfolio.
# Run once, then replace the files inside assets/images with real artwork.
Add-Type -AssemblyName System.Drawing

function New-PlaceholderImage {
    param(
        [string]$OutPath,
        [int]$W = 800,
        [int]$H = 600,
        [string]$From,
        [string]$To,
        [string]$Label,
        [string]$SubLabel,
        [switch]$Portrait
    )
    $bmp = [System.Drawing.Bitmap]::new($W, $H)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    try {
        $g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

        $rect = [System.Drawing.Rectangle]::new(0, 0, $W, $H)
        $c1   = [System.Drawing.ColorTranslator]::FromHtml($From)
        $c2   = [System.Drawing.ColorTranslator]::FromHtml($To)
        $grad = [System.Drawing.Drawing2D.LinearGradientBrush]::new($rect, $c1, $c2, 45.0)
        $g.FillRectangle($grad, $rect)
        $grad.Dispose()

        $rand = [System.Random]::new()
        for ($i = 0; $i -lt 7; $i++) {
            $d  = 30 + $rand.Next(-20, 110)
            $px = $rand.Next(-30, $W - 40)
            $py = $rand.Next(-30, $H - 40)
            $a  = [int](22 + $rand.Next(0, 26))
            $sb = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb($a, 255, 255, 255))
            $g.FillEllipse($sb, $px, $py, $d, $d)
            $sb.Dispose()
        }

        $penBig   = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(60, 255, 255, 255), 3)
        $penSmall = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(70, 255, 255, 255), 2)
        $penSmall.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
        $d1 = [int]($W * 0.30)
        $g.DrawEllipse($penBig,   $W - $d1 - 24, $H - $d1 - 24, $d1, $d1)
        $d2 = [int]($W * 0.16)
        $g.DrawEllipse($penSmall, 20, 20, $d2, $d2)
        $penBig.Dispose()
        $penSmall.Dispose()

        $fmt = [System.Drawing.StringFormat]::new()
        $fmt.Alignment     = [System.Drawing.StringAlignment]::Center
        $fmt.LineAlignment = [System.Drawing.StringAlignment]::Center

        if ($Portrait) {
            $r    = 130
            $cx   = [int]($W / 2)
            $cy   = [int]($H * 0.38)
            $faceRect = [System.Drawing.RectangleF]::new(($cx - $r), ($cy - $r), ($r * 2), ($r * 2))
            $face = [System.Drawing.Drawing2D.LinearGradientBrush]::new($faceRect,
                        [System.Drawing.Color]::FromArgb(255, 236, 72, 153),
                        [System.Drawing.Color]::FromArgb(255, 139, 92, 246), 135.0)
            $g.FillEllipse($face, $faceRect)
            $face.Dispose()
            $ring = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(120, 255, 255, 255), 4)
            $g.DrawEllipse($ring, $faceRect)
            $ring.Dispose()
            $mono  = [System.Drawing.Font]::new('Georgia', 84, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
            $white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
            $g.DrawString('AJ', $mono, $white, $faceRect, $fmt)
            $mono.Dispose()
            $nameFont = [System.Drawing.Font]::new('Georgia', 34, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
            $span     = [System.Drawing.RectangleF]::new(40, [int]($H * 0.66), ($W - 80), 46)
            $g.DrawString('APRIL JOYCE DAWAL', $nameFont, $white, $span, $fmt)
            $nameFont.Dispose()
            $roleFont = [System.Drawing.Font]::new('Segoe UI', 15, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
            $span2    = [System.Drawing.RectangleF]::new(40, [int]($H * 0.66) + 52, ($W - 80), 26)
            $g.DrawString('CREATIVE DESIGNER', $roleFont, $white, $span2, $fmt)
            $roleFont.Dispose()
            $white.Dispose()
        }
        else {
            $labelFont = [System.Drawing.Font]::new('Georgia', 24, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
            $span      = [System.Drawing.RectangleF]::new(40, ($H / 2 - 26), ($W - 80), 40)
            $white     = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(235, 255, 255, 255))
            $g.DrawString($Label, $labelFont, $white, $span, $fmt)
            $labelFont.Dispose()
            $subFont = [System.Drawing.Font]::new('Segoe UI', 12, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
            $span2   = [System.Drawing.RectangleF]::new(40, ($H / 2 + 20), ($W - 80), 24)
            $g.DrawString($SubLabel, $subFont, $white, $span2, $fmt)
            $subFont.Dispose()
            $white.Dispose()
        }
        $fmt.Dispose()
        $bmp.Save($OutPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
        Write-Host "Created: $OutPath"
    }
    finally {
        $g.Dispose()
        $bmp.Dispose()
    }
}

$imgDir = 'C:\xampp\htdocs\platform\april-joyce-portfolio\assets\images'

New-PlaceholderImage -OutPath (Join-Path $imgDir 'profile.jpg')  -W 900 -H 1100 -From '#7c3aed' -To '#ec4899' -Portrait
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-1.jpg') -W 800 -H 600 -From '#f0abfc' -To '#fb7185' -Label 'Social Media'  -SubLabel 'Sample Design'
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-2.jpg') -W 800 -H 600 -From '#a78bfa' -To '#c084fc' -Label 'Event Posters'  -SubLabel 'Sample Design'
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-3.jpg') -W 800 -H 600 -From '#818cf8' -To '#a78bfa' -Label 'Presentations' -SubLabel 'Sample Design'
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-4.jpg') -W 800 -H 600 -From '#fdba74' -To '#fb7185' -Label 'Promotional'   -SubLabel 'Sample Design'
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-5.jpg') -W 800 -H 600 -From '#f9a8d4' -To '#c4b5fd' -Label 'Invitations'   -SubLabel 'Sample Design'
New-PlaceholderImage -OutPath (Join-Path $imgDir 'project-6.jpg') -W 800 -H 600 -From '#8b5cf6' -To '#4f46e5' -Label 'Branding'      -SubLabel 'Sample Design'