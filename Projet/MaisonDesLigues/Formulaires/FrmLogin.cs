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
using Shadow;
using Microsoft.Win32;
using MaisonDesLigues.Utilitaires;

namespace MaisonDesLigues
{
    public partial class FrmLogin : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;
        internal Bdd connection;
        internal String TitreApplication;

        private ShadowWrapper _ombre;


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
            notif = new FlatAlertBox();
            
        }

        /// <summary> 
        /// Methode de connexion a la base de donnée via la form Login 
        /// </summary> 
        private void Login()
        {
            if (this.TxtLogin.Text != "" && this.TxtMdp.Text != "")
            {
                try
                {
                    this.connection = new Bdd(TxtLogin.Text, TxtMdp.Text);
                    (new FrmAdd()).Show(this);
                    //(new FrmPrincipale()).Show(this); 
                    this.Hide();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        /// <summary> 
        /// gestion événement click sur le bonton ok 
        /// </summary> 
        /// <param name="sender"></param> 
        /// <param name="e"></param> 
        private void CmdOk_Click(object sender, EventArgs e)
        {
            this.Login();
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
            //this.ControleValide(sender, e);
            _ombre = new ShadowWrapper(this);

        }

        private void FrmLogin_FormClosing(object sender, FormClosingEventArgs e)
        {
            Environment.Exit(1);
        }

        private void TxtMdp_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Enter)
            {
                this.Login();
            }
        }

        private void chkSouvenirMdp_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSouvenirMdp.Checked)
                GestionRegistre.CreerSauvegardeMdp();
            else
                GestionRegistre.SupprimerSauvegardeMdp();
        }


    }
}