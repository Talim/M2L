using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using BaseDeDonnees;
using System.Configuration;
using MaterialSkin.Controls;
using MaterialSkin;

namespace MaisonDesLigues
{
    public partial class FrmLogin : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;
        internal BaseDeDonnees.Bdd UneConnexion;
        internal String TitreApplication;
        internal Logger _logger;


        /// <summary>
        /// constructeur
        /// </summary>
        public FrmLogin()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);

            this.KeyDown += new KeyEventHandler(this.Form1_KeyDown);
        }

        private void Login()
        {
            try
            {
                UneConnexion = new Bdd(TxtLogin.Text, TxtMdp.Text);
                (new FrmAdd()).Show(this);
                //(new FrmPrincipale()).Show(this);
                this.Hide();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }


        }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            Console.WriteLine("ENTER");
            if (e.KeyCode == Keys.Enter)
            {
                Login();
            }
        }

        /// <summary>
        /// gestion événement click sur le bonton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CmdOk_Click(object sender, EventArgs e)
        {
            Login();
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