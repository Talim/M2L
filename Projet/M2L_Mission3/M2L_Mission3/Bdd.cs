using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Configuration;
using System.Windows.Forms;
using System.Collections.ObjectModel;
using System.Text.RegularExpressions;



namespace BaseDeDonnees
{
    /// <summary>
    /// Classe concernant la relation a la base de donnée
    /// </summary>
    public class Bdd
    {
        //VARIABLE
        private OracleConnection _oracleConnection;
        private OracleCommand _oracleOrder;
        private OracleDataAdapter _oracleDataAdapter;
        private OracleTransaction _oracleTransaction;
        private DataTable _dataTable;

        //METHODE
        /// <summary>
        /// Constructeur de la connexion
        /// </summary>
        /// <param name="UnLogin">Login utilisateur</param>
        /// <param name="UnPwd">Mot de passe utilisateur</param>
        public Bdd(String UnLogin, String UnPwd)
        {
            
            bool essaiCnxLocal = false;
            try
            {
                /// <remarks>
                /// On commence par récupérer dans CnString les informations contenues dans le fichier app.config
                /// pour la connectionString de nom StrConnMdl
                /// </remarks>
               
                ConnectionStringSettings CnString = ConfigurationManager.ConnectionStrings["StrConnMdl"];
                
                ///<remarks>
                /// On va remplacer dans la chaine de connexion les paramètres par le login et le pwd saisis
                /// dans les zones de texte. Pour ça on va utiliser la méthode Format de la classe String.
                /// 
                /// On essaie deux types de connexion, une à distance dans un premier temps et une en local
                /// dans un second temps.
                /// </remarks>

                string cnOut = string.Format(CnString.ConnectionString.ToString(),
                                          ConfigurationManager.AppSettings["SERVEROUT"],
                                          ConfigurationManager.AppSettings["PORTOUT"],
                                          ConfigurationManager.AppSettings["SID"],
                                          UnLogin,
                                          UnPwd);

                string cnIn  = string.Format(CnString.ConnectionString.ToString(),
                                          ConfigurationManager.AppSettings["SERVERIN"],
                                          ConfigurationManager.AppSettings["PORTIN"],
                                          ConfigurationManager.AppSettings["SID"], 
                                          UnLogin, 
                                          UnPwd);

                try
                {
                    // Connexion à distance
                    this._oracleConnection = new OracleConnection(cnOut);
                    this._oracleConnection.Open();
                    MessageBox.Show("Connexion à distance effectué avec succès !");
                }
                catch (OracleException Oex)
                {
                    essaiCnxLocal = true;
                }
                finally
                {
                    if (essaiCnxLocal)
                    {
                        this._oracleConnection = new OracleConnection(cnIn);
                        this._oracleConnection.Open();
                        MessageBox.Show("Connexion en local effectué avec succès !");
                    }

                }
            }
            catch (OracleException Oex)
            {
                if(Oex.Message.Substring(0,8) == "ORA-1017")
                    throw new Exception("Erreur à la connexion : Nom d'utilisateur ou mot de passe incorrect");
            }
        }

        /// <summary>
        /// Méthode permettant de fermer la connexion
        /// </summary>
        public void FermerConnexion()
        {
            this._oracleConnection.Close();
        }

        /// <summary>
        /// méthode permettant de renvoyer un message d'erreur provenant de la bd
        /// après l'avoir formatté. On ne renvoie que le message, sans code erreur
        /// </summary>
        /// <param name="unMessage">message à formater</param>
        /// <returns>message formaté à afficher dans l'application</returns>
        private String GetMessageOracle(String unMessage)
        {
            String[] message = Regex.Split(unMessage, "ORA-");
            return (Regex.Split(message[1], ":"))[1];
        }

        /// <summary>
        /// Function d'appel de la procedure stockée contenu dans le package gererParticipant, elle ajoute une participant à la table
        /// </summary>
        /// <param name="id"></param>
        /// <param name="dateArrivee"></param>
        /// <param name="cleWifi"></param>
        public void AddParticipant(int id, string dateArrivee, string cleWifi)
        {
            try
            {
                this._oracleOrder = new OracleCommand();
                this._oracleOrder.Connection = this._oracleConnection;
                this._oracleOrder.CommandText = "GERERPARTICIPANT.InsertParticipant";
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleOrder.Parameters.Add("p_DATEENREGISTREMENTARRIVEE", OracleDbType.Int32).Value = id;
                this._oracleOrder.Parameters.Add("p_DATEENREGISTREMENTARRIVEE", OracleDbType.Varchar2).Value = dateArrivee;
                this._oracleOrder.Parameters.Add("p_CLEWIFI", OracleDbType.Varchar2).Value = cleWifi;

                this._oracleOrder.ExecuteNonQuery();

            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// permet de récupérer le contenu d'une table ou d'une vue. 
        /// </summary>
        /// <param name="UneTableOuVue"> nom de la table ou la vue dont on veut récupérer le contenu</param>
        /// <returns>un objet de type datatable contenant les données récupérées</returns>
        public DataTable ObtenirDonnesOracle(String UneTableOuVue)
        {
            try
            {
                string sql = "select * from " + UneTableOuVue;
                this._oracleOrder = new OracleCommand(sql, this._oracleConnection);
                this._oracleDataAdapter = new OracleDataAdapter();
                this._oracleDataAdapter.SelectCommand = this._oracleOrder;
                this._dataTable = new DataTable();
                this._oracleDataAdapter.Fill(this._dataTable);
            }
            catch(OracleException ex)
            {
                MessageBox.Show(ex.Message + " ::: " + UneTableOuVue);
            }
            return _dataTable;
        }


    }
}
