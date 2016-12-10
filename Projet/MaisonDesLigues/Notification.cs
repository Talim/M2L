using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MaterialSkin.Controls;
using MaterialSkin;
using System.Windows.Forms;
using System.Drawing;

namespace MaisonDesLigues
{
    class Notification
    {
        private static FormNotif notif;

        public static void ShowNotification(MaterialForm frm, string title, string message, int time)
        {
            notif = (new FormNotif());
            notif.Show(frm);

            notif.Title = title;
            notif.Message = message;

            notif.Location = new Point(frm.Size.Width + frm.Location.X, frm.Size.Height + frm.Location.Y - notif.Size.Height);

        }
    }
}
