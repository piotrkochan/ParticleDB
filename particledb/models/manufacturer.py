from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship, backref

from . import Base

class Manufacturer(Base):
    """ Represents a part's manufacturer.
    """
    __tablename__ = 'manufacturers'

    id = Column('id', Integer, primary_key=True)
    name = Column('name', String(45), nullable=False)
    logofile = Column('logofile', String(45))
    parts = relationship("Part", backref="manufacturer")