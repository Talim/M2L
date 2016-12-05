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
        private DataTable atelierData;


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

        private void GetAtelier()
        {
            try
            {
                atelierData = UneConnexion.ObtenirDonnesOracle("atelier");
            }
            catch (Oracle.DataAccess.Client.OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            comboBox_Ateliers.Items.Clear();
            for (int i = 0; i < atelierData.Rows.Count; i++)
            {
                comboBox_Ateliers.Items.Add(atelierData.Rows[i]["LIBELLEATELIER"]);
                comboBox_Atelier_Vacations.Items.Add(atelierData.Rows[i]["LIBELLEATELIER"]);
            }
            if (comboBox_Ateliers.Items.Count > 0)
            {
                comboBox_Ateliers.SelectedIndex = 0;
                comboBox_Atelier_Vacations.SelectedIndex = 0;
            }

            //MessageBox.Show("Nb place : " + (atelierData.Rows[1]["NBPLACESMAXI"]));

        }

        private void FrmAdd_Load(object sender, EventArgs e)
        {
            try
            {
                UneConnexion = ((FrmLogin)Owner).UneConnexion;
            }catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }

            GetAtelier();
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
            GetAtelier();
        }

        private void materialFlatButton_AjouterTheme_Click(object sender, EventArgs e)
        {
            UneConnexion.AddTheme(materialSingleLineTextField_LibelleTheme.Text, Convert.ToInt32(atelierData.Rows[comboBox_Ateliers.SelectedIndex]["ID"]));
        }
    }
}