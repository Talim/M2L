using System;
using System.Data;
using BaseDeDonnees;
using Oracle.ManagedDataAccess.Client;
using MaterialSkin.Controls;
using MaterialSkin;

namespace MaisonDesLigues
{
    public partial class FrmAdd : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        private Bdd _connection;
        private DataTable _atelierData;
        private DataTable _vacationData;

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
            try
            {
                this._connection = ((FrmLogin)Owner).connection;
            }catch(Exception ex)
            {
                throw new Exception(ex.Message);
            }

            this.GetAteliers();
            this.GetVacations();
        }

        /// <summary>
        /// permet d'obtenir la liste des ateliers
        /// </summary>
        private void GetAteliers()
        {

            try
            {
                this._atelierData = this._connection.ObtenirDonnesOracle("atelier");
            }
            catch (OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            comboBox_Ateliers.Items.Clear();
            for (int i = 0; i < this._atelierData.Rows.Count; i++)
            {
                comboBox_Ateliers.Items.Add(this._atelierData.Rows[i]["LIBELLEATELIER"]);
                comboBox_Atelier_Vacations.Items.Add(this._atelierData.Rows[i]["LIBELLEATELIER"]);
            }
            if (comboBox_Ateliers.Items.Count > 0)
            {
                comboBox_Ateliers.SelectedIndex = 0;
                comboBox_Atelier_Vacations.SelectedIndex = 0;
            }
        }

        /// <summary>
        /// Permet d'obetnir la liste des vacations
        /// </summary>
        private void GetVacations()
        {
            try
            {
                this._vacationData = this._connection.ObtenirDonnesOracle("vacation");
            }
            catch (OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            this.comboBox_Vacations.Items.Clear();
            for (int i = 0; i < this._vacationData.Rows.Count; i++)
            {
                for (int j = 0; j < this._atelierData.Rows.Count; j++)
                {
                    if (Convert.ToInt32(this._atelierData.Rows[j]["ID"]) == Convert.ToInt32(this._vacationData.Rows[i]["IDATELIER"]))
                    {
                        comboBox_Vacations.Items.Add(this._vacationData.Rows[i]["NUMERO"] + "- " + this._atelierData.Rows[j]["LIBELLEATELIER"]);
                    }
                }
            }
            if (comboBox_Vacations.Items.Count > 0)
            {
                comboBox_Vacations.SelectedIndex = 0;
            }
        }

        private void comboBox_Vacations_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox_heureDebutModifier.Text = Utilitaire.GetTimeFromDateTimeString(this._vacationData.Rows[comboBox_Vacations.SelectedIndex]["HEUREDEBUT"].ToString());
            textBox_HeureFinModifier.Text = Utilitaire.GetTimeFromDateTimeString(this._vacationData.Rows[comboBox_Vacations.SelectedIndex]["HEUREFIN"].ToString());
        }

        //Ajouter un thème
        private void btn_AjouterTheme_Click(object sender, EventArgs e)
        {
            this._connection.AddTheme(textField_LibelleTheme.Text, Convert.ToInt32(this._atelierData.Rows[comboBox_Ateliers.SelectedIndex]["ID"]));
        }

        //Ajouter une vacation
        private void btn_AjouterVacations_Click(object sender, EventArgs e)
        {
            this._connection.AddVacation(Convert.ToInt32(this._atelierData.Rows[comboBox_Atelier_Vacations.SelectedIndex]["ID"]), textBox_HeureDebut.Text, textBox_HeureFin.Text);
            this.GetVacations();
        }

        //Modifier une vacation
        private void btn_modifierVacation_Click(object sender, EventArgs e)
        {
            this._connection.UpdateVacation(Convert.ToInt32(this._vacationData.Rows[comboBox_Vacations.SelectedIndex]["NUMERO"]), textBox_heureDebutModifier.Text, textBox_HeureFinModifier.Text);
        }

        //Ajouter un atelier
        private void btn_ajouterAtelier_Click(object sender, EventArgs e)
        {
            this._connection.AddAtelier(textField_atelier.Text, Convert.ToInt32(textBox_nbPlaceAtelier.Text));
            this.GetAteliers();
        }
    }
}