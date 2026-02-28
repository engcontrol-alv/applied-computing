import logging
import os
from datetime import datetime
from typing import Optional

class SystemLogger:
    def __init__(self, name: str, log_file: Optional[str] = ".system.log", show_console: bool = False):
        self.logger = logging.getLogger(name)
        self.logger.setLevel(logging.INFO)

        if not self.logger.handlers:
            formatter = logging.Formatter(
                '%(asctime)s | [%(name)s] | %(levelname)s | %(message)s',
                datefmt='%Y-%m-%d %H:%M:%S'
            )

            # O Handler do Console agora é condicional
            if show_console:
                console = logging.StreamHandler()
                console.setFormatter(formatter)
                self.logger.addHandler(console)

            if log_file:
                # Handler para arquivo (Auditoria histórica)
                # O uso do "." no início do nome torna o arquivo oculto/discreto
                file_h = logging.FileHandler(log_file, encoding='utf-8')
                file_h.setFormatter(formatter)
                self.logger.addHandler(file_h)

    def get_logger(self):
        return self.logger
    
def setup_logger(module_name: str, log_file: str = ".currency_extraction.log", show_console: bool = False):
    """
    Factory function atualizada para suportar logs invisíveis e silenciar console.
    """
    return SystemLogger(module_name, log_file=log_file, show_console=show_console).get_logger()