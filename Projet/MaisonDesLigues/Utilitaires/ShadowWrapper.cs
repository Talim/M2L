using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Shadow;
using System.ComponentModel;
using System.Drawing;

namespace MaisonDesLigues.Utilitaires
{
    class ShadowWrapper : Component
    {
        Form _maForm;
        Dropshadow _monOmbre;

        public ShadowWrapper(Form f)
        {
            _maForm = f;
            _monOmbre = new Dropshadow(_maForm);
            creerOmbre();
        }
        private void creerOmbre()
        {
            if (!DesignMode)
            {
                _monOmbre = new Dropshadow(_maForm)
                {
                    ShadowBlur = 10,
                    ShadowSpread = -4,
                    ShadowColor = Color.FromArgb(33, 33, 33)
                };
                _monOmbre.RefreshShadow();
                _monOmbre.Refresh();
            }
        }



    }
}
