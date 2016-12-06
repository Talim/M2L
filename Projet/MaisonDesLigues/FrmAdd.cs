using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using BaseDeDonnees;
using Oracle.ManagedDataAccess.Client;
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
        private DataTable vacationData;


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


        //Obtenir la liste des ateliers
        private void GetAtelier()
        {
            try
            {
                atelierData = UneConnexion.ObtenirDonnesOracle("atelier");
            }
            catch (OracleException ex)
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
        }

        //Obtenir la listes des vacations
        private void GetVacation()
        {
            try
            {
                this.vacationData = UneConnexion.ObtenirDonnesOracle("vacation");
            }
            catch (OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            this.comboBox_Vacations.Items.Clear();
            for (int i = 0; i < this.vacationData.Rows.Count; i++)
            {
                for (int j = 0; j < this.atelierData.Rows.Count; j++) {
                    if (Convert.ToInt32(atelierData.Rows[j]["ID"]) == Convert.ToInt32(vacationData.Rows[i]["IDATELIER"])) {
                        comboBox_Vacations.Items.Add(vacationData.Rows[i]["NUMERO"] + "- " + atelierData.Rows[j]["LIBELLEATELIER"]);
                    }
                }
            }
            if (comboBox_Vacations.Items.Count > 0)
            {
                comboBox_Vacations.SelectedIndex = 0;
            }
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

            this.GetAtelier();
            this.GetVacation();
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

        private void materialFlatButton_AjouterVacations_Click(object sender, EventArgs e)
        {
            UneConnexion.AddVacation(Convert.ToInt32(atelierData.Rows[comboBox_Atelier_Vacations.SelectedIndex]["ID"]), maskedTextBox_HeureDebut.Text, maskedTextBox_HeureFin.Text);
            this.GetVacation();
        }

        private string GetHoursFromDateTime(string dateTime)
        {
            DateTime time = DateTime.Parse(dateTime);
            return time.Hour + ":" + time.Minute;
        }

        private void comboBox_Vacations_SelectedIndexChanged(object sender, EventArgs e)
        {
            maskedTextBox_heureDebutModifier.Text = GetHoursFromDateTime(vacationData.Rows[comboBox_Vacations.SelectedIndex]["HEUREDEBUT"].ToString());
            maskedTextBox_HeureFinModifier.Text = GetHoursFromDateTime(vacationData.Rows[comboBox_Vacations.SelectedIndex]["HEUREFIN"].ToString());
        }

        private void materialFlatButton_modifier_Click(object sender, EventArgs e)
        {
            UneConnexion.UpdateVacation(Convert.ToInt32(vacationData.Rows[comboBox_Vacations.SelectedIndex]["NUMERO"]), maskedTextBox_heureDebutModifier.Text, maskedTextBox_HeureFinModifier.Text);
        }
    }
}