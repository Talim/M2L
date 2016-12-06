using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Oracle.ManagedDataAccess.Client;
using System.Configuration;
using System.Windows.Forms;
using System.Collections.ObjectModel;
using System.Text.RegularExpressions;
using MaisonDesLigues;



namespace BaseDeDonnees
{
    public class Bdd
    {
        //VARIABLE
        private OracleConnection _oracleConnection;
        private OracleCommand _oracleOrder;
        private OracleDataAdapter _oracleDataAdapter;
        private OracleTransaction _oracleTransaction;
        private DataTable _dataTable;
        private Logger _logger;

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
        /// Méthode permettant d'ajouter un atelier a la bd
        /// </summary>
        /// <param name="libelle">libelle de l'atelier</param>
        /// <param name="nbPlace">nombre de place de l'atelier</param>
        public void AddAtelier(string libelle, int nbPlace)
        {
            try
            {
                this._oracleOrder = new OracleCommand();
                this._oracleOrder.Connection = this._oracleConnection;
                this._oracleOrder.CommandText = "GERERATELIER.InsertAtelier";
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleOrder.Parameters.Add("p_LIBELLEATELIER", OracleDbType.Varchar2).Value = libelle;
                this._oracleOrder.Parameters.Add("p_NBPLACESMAXI", OracleDbType.Int32).Value = nbPlace;

                this._oracleOrder.ExecuteNonQuery();

            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Méthode permettant d'ajouter un thème
        /// </summary>
        /// <param name="libelle">libellé du thème</param>
        /// <param name="idAtelier">id de l'atelier lié au thème</param>
        public void AddTheme(string libelle, int idAtelier)
        {
            try
            {
                this._oracleOrder = new OracleCommand();
                this._oracleOrder.Connection = this._oracleConnection;
                this._oracleOrder.CommandText = "GERERTHEME.InsertTheme";
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleOrder.Parameters.Add("p_IDATELIER", OracleDbType.Int32).Value = idAtelier;
                this._oracleOrder.Parameters.Add("p_LIBELLETHEME", OracleDbType.Varchar2).Value = libelle;

                this._oracleOrder.ExecuteNonQuery();

            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Met à jour une vacation
        /// </summary>
        /// <param name="numero">numéro de la vaction a mettre à jour</param>
        /// <param name="heureDebut">nouvelle heure de début</param>
        /// <param name="heureFin">nouvelle heure de fin</param>
        public void UpdateVacation(int numero, string heureDebut, string heureFin)
        {
            try
            {
                this._oracleOrder = new OracleCommand();
                this._oracleOrder.Connection = this._oracleConnection;
                this._oracleOrder.CommandText = "GERERVACATION.UpdateVacation";
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleOrder.Parameters.Add("p_NUMERO", OracleDbType.Int32).Value = numero;
                this._oracleOrder.Parameters.Add("p_HEUREDEBUT", OracleDbType.Varchar2).Value = Utilitaire.GetDateTime(heureDebut).ToString();
                this._oracleOrder.Parameters.Add("p_HEUREFIN", OracleDbType.Varchar2).Value = Utilitaire.GetDateTime(heureFin).ToString();

                this._oracleOrder.ExecuteNonQuery();

            }
            catch (OracleException ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        /// <summary>
        /// Ajoute une nouvelle vacation
        /// </summary>
        /// <param name="idAtelier">id de l'atelier lié a la vacation</param>
        /// <param name="heureDebut">heure de début</param>
        /// <param name="heureFin">heure de fin</param>
        public void AddVacation(int idAtelier, string heureDebut, string heureFin)
        {
            try
            {
                this._oracleOrder = new OracleCommand();
                this._oracleOrder.Connection = this._oracleConnection;
                this._oracleOrder.CommandText = "GERERVACATION.InsertVacation";
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleOrder.Parameters.Add("p_IDATELIER", OracleDbType.Int32).Value = idAtelier;
                this._oracleOrder.Parameters.Add("p_HEUREDEBUT", OracleDbType.Varchar2).Value = Utilitaire.GetDateTime(heureDebut).ToString();
                this._oracleOrder.Parameters.Add("p_HEUREFIN", OracleDbType.Varchar2).Value = Utilitaire.GetDateTime(heureFin).ToString();

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

        /// <summary>
        /// méthode privée permettant de valoriser les paramètres d'un objet commmand communs aux licenciés, bénévoles et intervenants
        /// </summary>
        /// <param name="Cmd">nom de l'objet command concerné par les paramètres</param>
        /// <param name="pNom">nom du participant</param>
        /// <param name="pPrenom">prénom du participant</param>
        /// <param name="pAdresse1">adresse1 du participant</param>
        /// <param name="pAdresse2">adresse2 du participant</param>
        /// <param name="pCp">cp du participant</param>
        /// <param name="pVille">ville du participant</param>
        /// <param name="pTel">téléphone du participant</param>
        /// <param name="pMail">mail du participant</param>
        private void ParamCommunsNouveauxParticipants(OracleCommand Cmd, String pNom, String pPrenom, String pAdresse1, String pAdresse2, String pCp, String pVille, String pTel, String pMail)
        {
            Cmd.Parameters.Add("pNom", OracleDbType.Varchar2, ParameterDirection.Input).Value = pNom;
            Cmd.Parameters.Add("pPrenom", OracleDbType.Varchar2, ParameterDirection.Input).Value = pPrenom;
            Cmd.Parameters.Add("pAdr1", OracleDbType.Varchar2, ParameterDirection.Input).Value = pAdresse1;
            Cmd.Parameters.Add("pAdr2", OracleDbType.Varchar2, ParameterDirection.Input).Value = pAdresse2;
            Cmd.Parameters.Add("pCp", OracleDbType.Varchar2, ParameterDirection.Input).Value = pCp;
            Cmd.Parameters.Add("pVille", OracleDbType.Varchar2, ParameterDirection.Input).Value = pVille;
            Cmd.Parameters.Add("pTel", OracleDbType.Varchar2, ParameterDirection.Input).Value = pTel;
            Cmd.Parameters.Add("pMail", OracleDbType.Varchar2, ParameterDirection.Input).Value = pMail;
        }

        /// <summary>
        /// procédure qui va se charger d'invoquer la procédure stockée qui ira inscrire un participant de type bénévole
        /// </summary>
        /// <param name="Cmd">nom de l'objet command concerné par les paramètres</param>
        /// <param name="pNom">nom du participant</param>
        /// <param name="pPrenom">prénom du participant</param>
        /// <param name="pAdresse1">adresse1 du participant</param>
        /// <param name="pAdresse2">adresse2 du participant</param>
        /// <param name="pCp">cp du participant</param>
        /// <param name="pVille">ville du participant</param>
        /// <param name="pTel">téléphone du participant</param>
        /// <param name="pMail">mail du participant</param>
        /// <param name="pDateNaissance">mail du bénévole</param>
        /// <param name="pNumeroLicence">numéro de licence du bénévole ou null</param>
        /// <param name="pDateBenevolat">collection des id des dates où le bénévole sera présent</param>
        public void InscrireBenevole(String pNom, String pPrenom, String pAdresse1, String pAdresse2, String pCp, String pVille, String pTel, String pMail, DateTime pDateNaissance, Int64? pNumeroLicence, Collection<Int16> pDateBenevolat)
        {
            try
            {
                this._oracleOrder = new OracleCommand("pckparticipant.nouveaubenevole", this._oracleConnection);
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this.ParamCommunsNouveauxParticipants(this._oracleOrder, pNom, pPrenom, pAdresse1, pAdresse2, pCp, pVille, pTel, pMail);
                this._oracleOrder.Parameters.Add("pDateNaiss", OracleDbType.Date, ParameterDirection.Input).Value = pDateNaissance;
                this._oracleOrder.Parameters.Add("pLicence", OracleDbType.Int64, ParameterDirection.Input).Value = pNumeroLicence;
                //UneOracleCommand.Parameters.Add("pLesDates", OracleDbType.Array, ParameterDirection.Input).Value = pDateBenevolat;
                OracleParameter pLesDates = new OracleParameter();
                pLesDates.ParameterName = "pLesDates";
                pLesDates.OracleDbType = OracleDbType.Int16;
                pLesDates.CollectionType = OracleCollectionType.PLSQLAssociativeArray;

                pLesDates.Value = pDateBenevolat.ToArray();
                pLesDates.Size = pDateBenevolat.Count;
                this._oracleOrder.Parameters.Add(pLesDates);
                this._oracleOrder.ExecuteNonQuery();
                MessageBox.Show("inscription bénévole effectuée");
            }
            catch (OracleException Oex)
            {
                MessageBox.Show("Erreur Oracle \n" + Oex.Message);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Autre Erreur  \n" + ex.Message);
            }

        }

        /// <summary>
        /// méthode privée permettant de valoriser les paramètres d'un objet commmand spécifiques intervenants
        /// </summary>
        /// <param name="Cmd"> nom de l'objet command concerné par les paramètres</param>
        /// <param name="pIdAtelier"> Id de l'atelier où interviendra l'intervenant</param>
        /// <param name="pIdStatut">statut de l'intervenant pour l'atelier : animateur ou intervenant</param>
        private void ParamsSpecifiquesIntervenant(OracleCommand Cmd,Int16 pIdAtelier, String pIdStatut)
        {
            Cmd.Parameters.Add("pIdAtelier", OracleDbType.Int16, ParameterDirection.Input).Value = pIdAtelier;
            Cmd.Parameters.Add("pIdStatut", OracleDbType.Char, ParameterDirection.Input).Value = pIdStatut;
        }

        /// <summary>
        /// Procédure publique qui va appeler la procédure stockée permettant d'inscrire un nouvel intervenant sans nuité
        /// </summary>
        /// <param name="Cmd">nom de l'objet command concerné par les paramètres</param>
        /// <param name="pNom">nom du participant</param>
        /// <param name="pPrenom">prénom du participant</param>
        /// <param name="pAdresse1">adresse1 du participant</param>
        /// <param name="pAdresse2">adresse2 du participant</param>
        /// <param name="pCp">cp du participant</param>
        /// <param name="pVille">ville du participant</param>
        /// <param name="pTel">téléphone du participant</param>
        /// <param name="pMail">mail du participant</param>
        /// <param name="pIdAtelier"> Id de l'atelier où interviendra l'intervenant</param>
        /// <param name="pIdStatut">statut de l'intervenant pour l'atelier : animateur ou intervenant</param>
        public void InscrireIntervenant(String pNom, String pPrenom, String pAdresse1, String pAdresse2, String pCp, String pVille, String pTel, String pMail, Int16 pIdAtelier, String pIdStatut)
        {
            /// <remarks>
            /// procédure qui va créer :
            /// 1- un enregistrement dans la table participant
            /// 2- un enregistrement dans la table intervenant 
            ///  en cas d'erreur Oracle, appel à la méthode GetMessageOracle dont le rôle est d'extraire uniquement le message renvoyé
            /// par une procédure ou un trigger Oracle
            /// </remarks>
            /// 
            String MessageErreur = "";
            try
            {
                this._oracleOrder = new OracleCommand("pckparticipant.nouvelintervenant", this._oracleConnection);
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                this._oracleTransaction = this._oracleConnection.BeginTransaction();
                this.ParamCommunsNouveauxParticipants(this._oracleOrder, pNom, pPrenom, pAdresse1, pAdresse2, pCp, pVille, pTel, pMail);
                this.ParamsSpecifiquesIntervenant(this._oracleOrder, pIdAtelier, pIdStatut);
                this._oracleOrder.ExecuteNonQuery();
                this._oracleTransaction.Commit();
            }
            catch (OracleException Oex)
            {
                MessageErreur = "Erreur Oracle \n" + this.GetMessageOracle(Oex.Message);
             }
            catch (Exception ex)
            {

                MessageErreur = "Autre Erreur, les informations n'ont pas été correctement saisies";
            }
            finally
            {
                if (MessageErreur.Length > 0)
                {
                    this._oracleTransaction.Rollback();
                    throw new Exception(MessageErreur);
                }
            }
        }
        
        /// <summary>
        /// Procédure publique qui va appeler la procédure stockée permettant d'inscrire un nouvel intervenant qui aura des nuités
        /// </summary>
        /// <param name="Cmd">nom de l'objet command concerné par les paramètres</param>
        /// <param name="pNom">nom du participant</param>
        /// <param name="pPrenom">prénom du participant</param>
        /// <param name="pAdresse1">adresse1 du participant</param>
        /// <param name="pAdresse2">adresse2 du participant</param>
        /// <param name="pCp">cp du participant</param>
        /// <param name="pVille">ville du participant</param>
        /// <param name="pTel">téléphone du participant</param>
        /// <param name="pMail">mail du participant</param>
        /// <param name="pIdAtelier"> Id de l'atelier où interviendra l'intervenant</param>
        /// <param name="pIdStatut">statut de l'intervenant pour l'atelier : animateur ou intervenant</param>
        /// <param name="pLesCategories">tableau contenant la catégorie de chambre pour chaque nuité à réserver</param>
        /// <param name="pLesHotels">tableau contenant l'hôtel pour chaque nuité à réserver</param>
        /// <param name="pLesNuits">tableau contenant l'id de la date d'arrivée pour chaque nuité à réserver</param>
        public void InscrireIntervenant(String pNom, String pPrenom, String pAdresse1, String pAdresse2, String pCp, String pVille, String pTel, String pMail, Int16 pIdAtelier, String pIdStatut, Collection<string> pLesCategories, Collection<string> pLesHotels, Collection<Int16>pLesNuits)
        {
            /// <remarks>
            /// procédure qui va  :
            /// 1- faire appel à la procédure 
            /// un enregistrement dans la table participant
            /// 2- un enregistrement dans la table intervenant 
            /// 3- un à 2 enregistrements dans la table CONTENUHEBERGEMENT
            /// 
            /// en cas d'erreur Oracle, appel à la méthode GetMessageOracle dont le rôle est d'extraire uniquement le message renvoyé
            /// par une procédure ou un trigger Oracle
            /// </remarks>
            /// 
            String MessageErreur="";
            try
            {
                // pckparticipant.nouvelintervenant est une procédure surchargée
                this._oracleOrder = new OracleCommand("pckparticipant.nouvelintervenant", this._oracleConnection);
                this._oracleOrder.CommandType = CommandType.StoredProcedure;
                // début de la transaction Oracle : il vaut mieyx gérer les transactions dans l'applicatif que dans la bd.
                this._oracleTransaction = this._oracleConnection.BeginTransaction();
                this.ParamCommunsNouveauxParticipants(this._oracleOrder, pNom, pPrenom, pAdresse1, pAdresse2, pCp, pVille, pTel, pMail);
                this.ParamsSpecifiquesIntervenant(this._oracleOrder, pIdAtelier, pIdStatut);

                /*
                On va créer ici les paramètres spécifiques à l'inscription d'un intervenant qui réserve des nuits d'hôtel.
                Paramètre qui stocke les catégories sélectionnées
                */
                OracleParameter pOraLescategories = new OracleParameter();
                pOraLescategories.ParameterName = "pLesCategories";
                pOraLescategories.OracleDbType = OracleDbType.Char;
                pOraLescategories.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                pOraLescategories.Value = pLesCategories.ToArray();
                pOraLescategories.Size = pLesCategories.Count;
                this._oracleOrder.Parameters.Add(pOraLescategories);
               
                // Paramètre qui stocke les hotels sélectionnées
                OracleParameter pOraLesHotels = new OracleParameter();
                pOraLesHotels.ParameterName = "pLesHotels";
                pOraLesHotels.OracleDbType = OracleDbType.Char;
                pOraLesHotels.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                pOraLesHotels.Value = pLesHotels.ToArray();
                pOraLesHotels.Size = pLesHotels.Count;
                this._oracleOrder.Parameters.Add(pOraLesHotels);
                
                // Paramètres qui stocke les nuits sélectionnées
                OracleParameter pOraLesNuits = new OracleParameter();
                pOraLesNuits.ParameterName = "pLesNuits";
                pOraLesNuits.OracleDbType = OracleDbType.Int16;
                pOraLesNuits.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
                pOraLesNuits.Value = pLesNuits.ToArray();
                pOraLesNuits.Size = pLesNuits.Count;
                this._oracleOrder.Parameters.Add(pOraLesNuits);
                
                this._oracleOrder.ExecuteNonQuery();
                this._oracleTransaction.Commit();
               
            }
            catch (OracleException Oex)
            {
                MessageErreur="Erreur Oracle \n" + this.GetMessageOracle(Oex.Message);
            }
            catch (Exception ex)
            {
                MessageErreur= "Autre Erreur, les informations n'ont pas été correctement saisies";
            }
            finally
            {
                if (MessageErreur.Length > 0)
                {
                    this._oracleTransaction.Rollback();
                    throw new Exception(MessageErreur);
                }             
            }
        }
        
        /// <summary>
        /// fonction permettant de construire un dictionnaire dont l'id est l'id d'une nuité et le contenu une date
        /// sous la la forme : lundi 7 janvier 2013        /// 
        /// </summary>
        /// <returns>un dictionnaire dont l'id est l'id d'une nuité et le contenu une date</returns>
        public Dictionary<Int16, String> ObtenirDatesNuites()
        {
            Dictionary<Int16, String> LesDatesARetourner = new Dictionary<Int16, String>();
            DataTable LesDatesNuites = this.ObtenirDonnesOracle("VDATENUITE01");
            foreach (DataRow UneLigne in LesDatesNuites.Rows)
            {
                LesDatesARetourner.Add(Convert.ToInt16(UneLigne["id"]), UneLigne["libelle"].ToString());
            }
            return LesDatesARetourner;

        }

    }
}
