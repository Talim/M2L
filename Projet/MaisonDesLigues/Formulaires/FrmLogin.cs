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
<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
using System.Threading;
=======
using Shadow;
using Microsoft.Win32;
using MaisonDesLigues.Utilitaires;
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs

namespace MaisonDesLigues
{
    public partial class FrmLogin : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        internal Bdd connection;
        internal String TitreApplication;

        private ShadowWrapper _ombre;

<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
        /// <summary>
        /// Constructeur
        /// </summary>
=======

        /// <summary> 
        /// constructeur 
        /// </summary> 
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
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
<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
            //Notification.ShowNotification(this, "test", "test", 1000);
=======
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
            if (this.TxtLogin.Text != "" && this.TxtMdp.Text != "")
            {
                try
                {
                    this.connection = new Bdd(TxtLogin.Text, TxtMdp.Text);
<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs

=======
                    (new FrmAdd()).Show(this);
                    //(new FrmPrincipale()).Show(this); 
                    this.Hide();
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
        /// <summary>
        /// Gestion événement click sur le bonton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
=======
        /// <summary> 
        /// gestion événement click sur le bonton ok 
        /// </summary> 
        /// <param name="sender"></param> 
        /// <param name="e"></param> 
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
        private void CmdOk_Click(object sender, EventArgs e)
        {
            CmdOk.Text = "Connexion...";
            loginWorker.RunWorkerAsync();
        }
<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
        /// <summary>
        /// Gestion de l'activation/désactivation du bouton ok
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
=======
        /// <summary> 
        /// gestion de l'activation/désactivation du bouton ok 
        /// </summary> 
        /// <param name="sender"></param> 
        /// <param name="e"></param> 
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
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

        /// <summary>
        /// Evenement complémentaire qui capture la touche entrée
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void TxtMdp_KeyPress(object sender, KeyPressEventArgs e)
        {
<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
            if(e.KeyChar == (char)Keys.Enter)
=======
            if (e.KeyChar == (char)Keys.Enter)
>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
            {
                CmdOk.Text = "Connexion...";
                loginWorker.RunWorkerAsync();
            }
        }

<<<<<<< HEAD:Projet/MaisonDesLigues/FrmLogin.cs
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
=======
        private void chkSouvenirMdp_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSouvenirMdp.Checked)
                GestionRegistre.CreerSauvegardeMdp();
            else
                GestionRegistre.SupprimerSauvegardeMdp();
        }


>>>>>>> master:Projet/MaisonDesLigues/Formulaires/FrmLogin.cs
    }
}