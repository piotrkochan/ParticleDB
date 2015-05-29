from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, backref

from . import Base

class Part(Base):
    """ Represents a specific part.
    """
    __tablename__ = 'parts'

    id = Column('id', Integer, primary_key=True)
    mpn = Column('mpn', String(45), unique=True, nullable=False)
    description = Column('description', String(45))
    manufacturers_id  = Column('manufacturers_id', Integer, ForeignKey('manufacturers.id'))
    parameters = relationship("Parameter", order_by="Parameter.order")
    stocks = relationship("Stock", backref="part")

    @property
    def in_stock(self):
        return len(self.stocks) > 0 and sum([i.quantity for i in self.stocks]) > 0