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
using Oracle.ManagedDataAccess.Client;
using Shadow;
using Microsoft.Win32;
using MaisonDesLigues.Utilitaires;

namespace MaisonDesLigues
{
    public partial class FrmStats : MaterialForm
    {
        private readonly MaterialSkinManager materialSkinManager;

        private Bdd UneConnexion;
        internal String TitreApplication;
        private DataTable _atelierData;

        private Dropshadow _ombre;
        
        /// <summary>
        /// Constructeur
        /// </summary>
        public FrmStats()
        {
            InitializeComponent();
            materialSkinManager = MaterialSkinManager.Instance;
            materialSkinManager.AddFormToManage(this);
            materialSkinManager.Theme = MaterialSkinManager.Themes.LIGHT;
            materialSkinManager.ColorScheme = new ColorScheme(Primary.BlueGrey800, Primary.BlueGrey900, Primary.BlueGrey500, Accent.LightBlue200, TextShade.WHITE);

        }


        private void FrmLogin_Load(object sender, EventArgs e)
        {
            //this.ControleValide(sender, e);

            if (!DesignMode)
            {
                _ombre = new Dropshadow(this)
                {
                    ShadowBlur = 10,
                    ShadowSpread = -4,
                    ShadowColor = Color.FromArgb(33, 33, 33)
                };
                _ombre.RefreshShadow();
                _ombre.Refresh();
            }

            UneConnexion = ((FrmMain)Owner).UneConnexion;

            GetAteliers();

        }

        private void FrmLogin_FormClosing(object sender, FormClosingEventArgs e)
        {
        //Fermeture
        }

        private void materialFlatButton1_Click(object sender, EventArgs e)
        {
            PrintPreviewDialog ppd = new PrintPreviewDialog();
            ppd.Document = this.chart1.Printing.PrintDocument;
            ppd.ShowDialog();
        }

        private void GetAteliers()
        {

            try
            {
                this._atelierData = this.UneConnexion.ObtenirDonnesOracle("atelier");
            }
            catch (OracleException ex)
            {
                throw new Exception(ex.Message);
            }
            comboBox_Ateliers.Items.Clear();
            for (int i = 0; i < this._atelierData.Rows.Count; i++)
            {
                comboBox_Ateliers.Items.Add(this._atelierData.Rows[i]["LIBELLEATELIER"]);
            }
            if (comboBox_Ateliers.Items.Count > 0)
            {
                comboBox_Ateliers.SelectedIndex = 0;
            }
        }

        private void comboBox_Ateliers_SelectedIndexChanged(object sender, EventArgs e)
        {

            this.chart1.Series.Clear();

            //Nom
            string[] seriesArray = { "TRES SATISFAIT", "SATISFAIT", "MOYENNEMENT SATISFAIT", "PAS DU TOUT SATISFAIT" };

            //Valeur
            int[] pointsArray = UneConnexion.GetStatsValue(Convert.ToInt32(this._atelierData.Rows[comboBox_Ateliers.SelectedIndex]["ID"]));

            this.chart1.Palette = System.Windows.Forms.DataVisualization.Charting.ChartColorPalette.Berry;
            this.chart1.Titles.Add("Statistiques des avis des participants");

            // Add series.
            for (int i = 0; i < seriesArray.Length; i++)
            {
                // Add series.
                System.Windows.Forms.DataVisualization.Charting.Series series = this.chart1.Series.Add(seriesArray[i]);

                // Add point.
                series.Points.Add(pointsArray[i]);
            }
        }
    }
}