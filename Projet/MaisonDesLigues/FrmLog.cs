using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MaterialSkin.Controls;
using MaterialSkin;
using BaseDeDonnees;
using System.Configuration;

namespace MaisonDesLigues
{
    public partial class FrmLog : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        public FrmLog()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
            TitreApplication = ConfigurationManager.AppSettings["TitreApplication"];
            this.Text = TitreApplication;
        }


        internal BaseDeDonnees.Bdd UneConnexion;
        internal String TitreApplication;
        /// <summary>
        /// gestion événement click sur le bonton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CmdOk_Click(object sender, EventArgs e)
        {
            try
            {
                //UneConnexion = new Bdd(TxtLogin.Text, TxtMdp.Text);
                (new FrmMain()).Show(this);
                this.Hide();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }


        }
        /// <summary>
        /// gestion de l'activation/désactivation du bouton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void ControleValide(object sender, EventArgs e)
        {
            if (TxtLogin.Text.Length == 0 || TxtMdp.Text.Length == 0)
                CmdOk.Enabled = false;
            else
                CmdOk.Enabled = true;
        }

        private void FrmLogin_Load(object sender, EventArgs e)
        {
            this.ControleValide(sender, e);
        }
    }
}

