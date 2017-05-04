using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MaisonDesLigues.Utilitaires
{
    /// <summary>
    /// Cette classe va nous servir à faire un audit 
    /// sur notre projet. Emulant flux sortie et 
    /// flux d'erreur.
    /// </summary>
    class Logger
    {
        private StringBuilder _out;
        private StringBuilder _err; 
        private Exception _ex;


        public Logger()
        {
            initLogger();
        }

        private void initLogger()
        {
            string cadreInitOut = @"====================================
                                    =      Flux de sortie standard     =
                                    ====================================";

            string cadreInitErr = @"====================================
                                    =      Flux d'erreur standard      =
                                    ====================================";

            _out = new StringBuilder(cadreInitOut + "\n\n");
            _err = new StringBuilder(cadreInitErr + "\n\n");
        }

        private string formatLog()
        {
            return '[' + DateTime.Now.ToShortDateString() + " - " + DateTime.Now.ToLongTimeString() + "]  • ";
        }

        public void Ajouter(string log)
        {
            _out.AppendLine(formatLog() + log);
        }

        public void AjouterErreur(string log)
        {
            _err.AppendLine(formatLog() + log);
        }

        public void Ajouter(Exception ex, string log)
        {
            _out.AppendLine(formatLog() + log);
        }

        public void AjouterErreur(Exception ex, string log)
        {
            _err.AppendLine(formatLog() + log);
        }

        public void Ajouter(string categorie, string log)
        {
            _out.AppendLine(formatLog() + "[log)");
            
        }

        public void AjouterErreur(string categorie, string log)
        {
            _err.AppendLine(formatLog() + log);
        }

    }
}
