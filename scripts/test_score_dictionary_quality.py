import tempfile
import unittest
from pathlib import Path
import sqlite3

from score_dictionary_quality import score_database, score_definition, source_hash


class QualityScoringTest(unittest.TestCase):
    def test_good_multi_sense_translation_scores_high(self):
        score, reasons = score_definition("hello; greeting; welcome", "bonjour; salutation; bienvenue", "fr")
        self.assertGreaterEqual(score, 80)
        self.assertEqual(reasons, [])

    def test_untranslated_short_copy_is_low_quality(self):
        score, reasons = score_definition("to manufacture", "to manufacture", "fr")
        self.assertLess(score, 55)
        self.assertIn("untranslated_copy", reasons)

    def test_database_output_is_idempotent_and_versioned(self):
        with tempfile.TemporaryDirectory() as temporary:
            db_path = Path(temporary) / "dictionary.db"
            connection = sqlite3.connect(db_path)
            connection.execute("CREATE TABLE words (id INTEGER PRIMARY KEY, simplified TEXT, definition TEXT, definition_fr TEXT)")
            connection.execute("INSERT INTO words VALUES (1, '造', 'to manufacture; to build; to invent', 'fabriquer')")
            connection.commit()
            connection.close()
            score_database(db_path, Path(temporary) / "reports", 55)
            score_database(db_path, Path(temporary) / "reports", 55)
            connection = sqlite3.connect(db_path)
            self.assertEqual(connection.execute("SELECT COUNT(*) FROM localized_definition_quality").fetchone()[0], 1)
            self.assertEqual(connection.execute("SELECT value FROM dictionary_metadata WHERE key='dictionary_schema_version'").fetchone()[0], "2")
            self.assertEqual(len(connection.execute("SELECT source_definition_hash FROM localized_definition_quality").fetchone()[0]), 32)
            connection.close()

    def test_hash_normalizes_whitespace(self):
        self.assertEqual(source_hash("one   two\nthree"), source_hash("one two three"))


if __name__ == "__main__":
    unittest.main()