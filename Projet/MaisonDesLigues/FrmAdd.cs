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
    public partial class FrmAdd : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;
        private Bdd UneConnexion;


        /// <summary>
        /// constructeur
        /// </summary>
        public FrmAdd()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
        }
        
        private void FrmAdd_Load(object sender, EventArgs e)
        {
            UneConnexion = ((FrmLogin)Owner).UneConnexion;
        }

        private void materialSingleLineTextField1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar) && (e.KeyChar != '.'))
            {
                e.Handled = true;
            }
        }

        private void btn_ajouterAtelier_Click(object sender, EventArgs e)
        {
            UneConnexion.AddAtelier(materialSingleLineTextField_libelle_atelier.Text, Convert.ToInt32(materialSingleLineTextField_nbPlaceAtelier.Text));
        }
    }
}