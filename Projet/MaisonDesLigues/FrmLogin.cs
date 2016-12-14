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
using System.Threading;

namespace MaisonDesLigues
{
    public partial class FrmLogin : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        internal Bdd connection;
        internal String TitreApplication;


        /// <summary>
        /// Constructeur
        /// </summary>
        public FrmLogin()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
        }

        /// <summary>
        /// Methode de connexion a la base de donnée via la form Login
        /// </summary>
        private void Login()
        {
            //Notification.ShowNotification(this, "test", "test", 1000);
            if (this.TxtLogin.Text != "" && this.TxtMdp.Text != "")
            {
                try
                {
                    this.connection = new Bdd(TxtLogin.Text, TxtMdp.Text);

                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        /// <summary>
        /// Gestion événement click sur le bonton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void CmdOk_Click(object sender, EventArgs e)
        {
            CmdOk.Text = "Connexion...";
            loginWorker.RunWorkerAsync();
        }
        /// <summary>
        /// Gestion de l'activation/désactivation du bouton ok
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

        private void FrmLogin_FormClosing(object sender, FormClosingEventArgs e)
        {
            Environment.Exit(1);
        }

        /// <summary>
        /// Evenement complémentaire qui capture la touche entrée
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void TxtMdp_KeyPress(object sender, KeyPressEventArgs e)
        {
            if(e.KeyChar == (char)Keys.Enter)
            {
                CmdOk.Text = "Connexion...";
                loginWorker.RunWorkerAsync();
            }
        }

        /// <summary>
        /// Methode de calcul du BackgroundWorker
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void loginWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            Login();
        }

        /// <summary>
        /// Methode de fin de calcul du BackgroundWorker (finally like...)
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void loginWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            CmdOk.Text = "Identification";
            (new FrmAdd()).Show(this);
            //(new FrmPrincipale()).Show(this);
            this.Hide();
            loginWorker.CancelAsync();
            loginWorker.Dispose();
        }
    }
}