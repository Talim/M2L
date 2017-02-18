using BaseDeDonnees;
using MaterialSkin;
using MaterialSkin.Controls;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace M2L_Mission3
{
    public partial class Inscription : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        private Bdd _connection;
        private DataTable _ParticipantData;
        public Inscription()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);
            this._connection= new Bdd("employemdl", "employemdl");
        }

        private void btn_Enregistrer_Click(object sender, EventArgs e)
        {
            int i = cmbBox_Participant.Text.IndexOf(":");
            int id = Int32.Parse(cmbBox_Participant.Text.Substring(0,i));
            this._connection.AddParticipant(id, dateTime_Arrive.Value.ToString(), Utilitaire.generateWifi(12));
        }

        private void dateTime_Inscription_ValueChanged(object sender, EventArgs e)
        {

        }

        private void Inscription_Load(object sender, EventArgs e)
        {
            this.GetParticipant();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void GetParticipant()
        {

            try
            {
                this._ParticipantData = this._connection.ObtenirDonnesOracle("participant");
            }
            catch (OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            cmbBox_Participant.Items.Clear();
            for (int i = 0; i < this._ParticipantData.Rows.Count; i++)
            {
                string value = this._ParticipantData.Rows[i]["ID"].ToString() +": " + this._ParticipantData.Rows[i]["NOMPARTICIPANT"].ToString() + " " + this._ParticipantData.Rows[i]["PRENOMPARTICIPANT"].ToString();
                cmbBox_Participant.Items.Add(value);
            }
            if (cmbBox_Participant.Items.Count > 0)
            {
                cmbBox_Participant.SelectedIndex = 0;
            }
        }
    }
}
