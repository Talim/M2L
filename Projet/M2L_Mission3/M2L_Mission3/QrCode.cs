using QRCoder;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace M2L_Mission3
{
    public class QrCode
    {
        /// <summary>
        /// Librairie venant du package nuget : Install-Package QRCoder
        /// </summary>
        /// <param name="data"></param>
        public void getQrCode(string data)
        {
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(data, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            Bitmap qrCodeImage = qrCode.GetGraphic(20);
            qrCodeImage.Save("../QrCode/"+data+".gif", System.Drawing.Imaging.ImageFormat.Gif);
        }

    }
}
