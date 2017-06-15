﻿///////////////////////////////////////////////////////////
//  NPCManager.as
//  Macromedia ActionScript Implementation of the Class NPCManager
//  Generated by Enterprise Architect
//  Original author: Kurniawan Fitriadi
///////////////////////////////////////////////////////////

package
{
	import com.game.CBaseTeelos;
	import com.game.CPlayerTeelos;
	import com.game.CTeeloBallistaTower;
	import com.game.CTeeloBaseSummoned;
	import com.game.CTeeloLastBarricade;
	import com.game.CTeeloSeeldy;
	import com.game.CTeeloTeegor;
	import com.game.CTeeloTeemy;
	import com.game.FACTION;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
		
	
	public class NPCManager extends EventDispatcher
	{
		// singleton instance
		static private var m_instance:NPCManager;
		
		// event constants
		static public const NPCEVENT_SPAWN:String 			= "spawn";
		static public const NPCEVENT_DIE:String 			= "die";
		
		static public const FACTION_PLAYER:String			= "player";
		static public const FACTION_ENEMY:String			= "enemy";
		

		// linked list
		private var m_head:CBaseTeelos;
		private var m_tail:CBaseTeelos;
		
		private var m_entityNames:Array;
		private var m_entityClasses:Array;
		
		private var m_entityCount:int;
		
		// lane database
		private var m_lane:Array;
		private var m_threatList:Array;
		
		private var m_tick:int;
		
		private var m_playerRef:int;
		private var m_enemyRef:int;
		
		
		
		/**
		 * 
		 * @param lock
		 */
		public function NPCManager(lock:SingletonLock)
		{
			initialize();
		}
		
		private function initialize(): void
		{
			m_head = null;
			m_tail = null;
			
			m_entityNames = [];
			m_entityClasses = [];
			m_lane = [];
			for( var i:int = 0; i < 5; i++ )
			{
				m_lane[i] = [];
				m_lane[i][FACTION_PLAYER] = [];
				m_lane[i][FACTION_ENEMY] = [];
			}
			
			m_threatList = [];
			
			m_entityCount = 0;
			m_tick = 0;
			m_playerRef = 0;
			m_enemyRef = 0;
		}
		
		private function registerToLane(npc:CBaseTeelos):void
		{
			var id:String = (npc is CPlayerTeelos) ? FACTION_PLAYER : FACTION_ENEMY;
			
			if ( npc is CTeeloTeegor )
			{
				for( var i:int = 0; i < 5; i++ )
					 m_lane[i][id].push( npc );
			}
			else
			{
				m_lane[npc.laneIndex][id].push( npc );
			}
		}
		
		public function getNearestEnemy(npc:CBaseTeelos):CBaseTeelos
		{
			var id:String = (npc is CPlayerTeelos) ? FACTION_PLAYER : FACTION_ENEMY;
			var lane:int = npc.laneIndex;
			var ret:CBaseTeelos = null;
			var nearest:int = 100000;
			
			if ( id == FACTION_PLAYER )
			{
				var enemyList:Array = m_lane[lane][FACTION_ENEMY];
				
				if ( ( npc.isDestinationReached() || npc is CTeeloBaseSummoned || 
					   npc is CTeeloTeemy || npc is CTeeloLastBarricade ) && enemyList.length > 0  )
				{
					for ( var i:int = 0; i < enemyList.length; i++ )
					{
						var enemy:CBaseTeelos = enemyList[i];
						
						if ( npc.x < enemy.x && !enemy.isDead() && (enemy.x - npc.x) < nearest && enemy.x < 800)
						{
							ret = enemy;
							nearest = enemy.x - npc.x;
						}
					}
				}
			}
			else
			{
				var playerList:Array = m_lane[lane][FACTION_PLAYER];
				if ( playerList.length > 0 )
				{
					for ( i = 0; i < playerList.length; i++ )
					{
						var player:CBaseTeelos = playerList[i];
						if (!player.isDead() && player.x < npc.x && (npc.x - player.x) < nearest &&
						     player.isStealthUnit() == npc.detectInvisible() )
						{
							ret = player;
							nearest = npc.x - player.x;
						}
					}
				}
			}
			
			if ( ret && nearest > npc.attackRange )
			{
				// cancel if not on range
				ret = null;
			}
				
			return ret;
		}
		
		public function getThreatList():Array
		{
			return m_threatList;
		}
		
		private function unregisterFromLane(npc:CBaseTeelos):void
		{
			var id:String = (npc is CPlayerTeelos) ? FACTION_PLAYER : FACTION_ENEMY;
			
			if ( npc is CTeeloTeegor )
			{
				for( var i:int = 0; i < 5; i++ )
					 m_lane[i][id].push( npc );
			}
			else
			{
				var index:int = m_lane[npc.laneIndex][id].indexOf(npc);
				if( index != -1 )
					m_lane[npc.laneIndex][id].splice(index, 1);
			}
		}
		
		public function registerEntity(entityClass:Object, initCount:int):void
		{
			var name:String = getQualifiedClassName(entityClass);
			
			m_entityNames.push(name);
			m_entityClasses[name] = entityClass;
			
			PoolManager.getInstance().registerClass(entityClass, initCount);
		}
		
		/**
		 * 
		 * @param npc
		 */
		
		public function add(entityClass:Object, lane:int, xPos:int, container:DisplayObjectContainer): CBaseTeelos
		{
			var entity:CBaseTeelos;
			
			m_entityCount++;
			
			var name:String = getQualifiedClassName(entityClass);
			entity = PoolManager.getInstance().borrowItem( m_entityClasses[name] );
			entity.onCreate(lane, xPos, container);
			entity.prev = null;
			entity.next = null;
			
			registerToLane(entity);
			
			// add to list
			if( m_head == null )
			{
				m_head = entity;
				m_tail = entity;
			}
			else
			{
				m_tail.next = entity;
				entity.prev = m_tail;
				m_tail = entity;
			}
			
			if ( entity == entity.next )
			{
				trace("Warning cyclic link detected!!" );
				throw new Error("Warning cyclic link detected!!");
			}
			
			switch( entity.getFaction() )
			{
				case FACTION.PLAYER:
						m_playerRef++;
						break;
				case FACTION.ENEMY:
						m_enemyRef++;
						break;	
			}
			
			dispatchEvent( new NPCEvent(NPCEVENT_SPAWN, entity) );
			return entity;
		}
		
		public function queryUnitByHit(x:int, y:int):CBaseTeelos
		{
			var npc:CBaseTeelos = m_head;
			var found:CBaseTeelos = null;
			
			while( npc != null && found == null ) 
			{
				if( npc.isActive() && npc.getFaction() == FACTION.PLAYER && npc.isPointCollide(x, y) && !CPlayerTeelos(npc).retreated )
				{
					found = npc;
				}
				npc = npc.next;
			}
			return found;
		}
		
		/**
		 * 
		 * @param elapsedTime
		 */
		public function update(elapsedTime:int): void
		{
			var npc:CBaseTeelos = m_head;
			
			while( npc != null ) 
			{
				if( npc.isActive() )
				{
					npc.update(elapsedTime);
					npc = npc.next;
				}
				else
				{
					var garbage:CBaseTeelos = npc;
					npc = npc.next;
					
					remove( garbage );
				}
			}
			
			m_tick += elapsedTime;
			if ( m_tick > 2000 )
			{
				sortPlayerLife();
				sortEnemyLife();
				sortThreatList();
				m_tick = 0;
			}
		}
		
		public function returnTrainCost(): int
		{
			var cost:int;
			var npc:CBaseTeelos = m_head;
			
			while( npc != null ) 
			{
				if( npc.isActive() )
				{
					if( npc.getFaction() == FACTION.PLAYER  )
					{
						cost += CPlayerTeelos(npc).getTrainingCost();
					}
				}
				npc = npc.next;
			}
			
			return cost;
		}
		
		public function clear(clearPlayer:Boolean, clearEnemy:Boolean): void
		{
			var npc:CBaseTeelos = m_head;
			
			while( npc != null ) 
			{
				if( npc.getFaction() == FACTION.PLAYER && clearPlayer ||
				    npc.getFaction() == FACTION.ENEMY && clearEnemy )
				{
					var garbage:CBaseTeelos = npc;
				}
				npc = npc.next;
					
				if( garbage )
					remove( garbage );
			}
			
			if ( clearPlayer )
				m_playerRef = 0;
				
			if ( clearEnemy )	
				m_enemyRef = 0;
		}
		
		public function removeBarricades():void
		{
			var npc:CBaseTeelos = m_head;
			while( npc != null ) 
			{
				if ( npc is CTeeloLastBarricade )
				{
					npc.setInactive();
					
					var garbage:CBaseTeelos = npc;
					npc = npc.next;
					
					remove( garbage, false );
				}
				else
				{
					npc = npc.next;
				}
			}
		}
		
		private function sortPlayerLife():void
		{
			for ( var i:int = 0; i < 5; i++ )
			{
				var list:Array = m_lane[i][FACTION_PLAYER];
				if ( list.length > 0 )
				{
					list.sortOn("lifePercentage");
				}
			}
		}
		
		private function sortEnemyLife():void
		{
			for ( var i:int = 0; i < 5; i++ )
			{
				var list:Array = m_lane[i][FACTION_ENEMY];
				if ( list.length > 0 )
				{
					list.sortOn("lifePercentage");
				}
			}
		}
		
		private function sortThreatList():void
		{
			if( m_threatList.length > 0 )
				m_threatList.splice(0, m_threatList.length);
				
			for ( var i:int = 0; i < 5; i++ )
			{
				var lane:Array = m_lane[i][FACTION_PLAYER];
				m_threatList[i] = lane.length;
			}
			
			m_threatList.sort();
			m_threatList.reverse();
		}
		
		public function killAll():void
		{
			var npc:CBaseTeelos = m_head;
								
			while( npc != null ) 
			{
				if( npc.isActive() )
				{
					npc.setInactive();
				}
				npc = npc.next;
			}
		}
		
		public function removeAll():void
		{
			var npc:CBaseTeelos = m_head;
			while( npc != null ) 
			{
				npc.setInactive();
				var garbage:CBaseTeelos = npc;
				npc = npc.next;
					
				remove( garbage, false );
				//sendToPool( garbage );
			}
			
			m_head = null;
			m_tail = null;
		}
		
		public function remove(unit:CBaseTeelos, broadcast:Boolean=true): void
		{
			m_entityCount--;
			unregisterFromLane(unit);
			unit.onRemove();
						
			if( broadcast )
				dispatchEvent( new NPCEvent(NPCEVENT_DIE, unit) );
				
			switch( unit.getFaction() )
			{
				case FACTION.PLAYER:
						m_playerRef--;
						break;
				case FACTION.ENEMY:
						m_enemyRef--;
						break;	
			}
			
			/* check if object is a list head */
			if( unit.prev == null )
			{
				if( unit.next != null )
				{
					m_head = unit.next;
					unit.next.prev = null;
					unit.next = null;
				}
				else 
				{
					m_head = null;
					m_tail = null;
				}
			}
			
			/* check if object is a list body */
			else if( unit.prev != null && unit.next != null )
			{
				// this is a body
				unit.prev.next = unit.next;
				unit.next.prev = unit.prev;
				
				unit.prev = null;
				unit.next = null;
			}
			
			/* check if object is a list tail */
			else if( unit.next == null )
			{
				if(unit.prev != null) 
				{
					// this is the tail
					m_tail = unit.prev;
					unit.prev.next = null;
					unit.prev = null;
				}
			}
			
			sendToPool( unit );
		}
		
		private function sendToPool(unit:CBaseTeelos): void
		{
			/* send object to pool */
			var found:Boolean = false;
			var length:int = m_entityNames.length;
			var index:int = 0;
			
			while ( !found && index < length )
			{
				var name:String = m_entityNames[index];
				if( unit is m_entityClasses[name] )
				{
					PoolManager.getInstance().recycleItem(m_entityClasses[name], unit);
					found = true;
				}
				index++;
			}
			
			if( !found )
			{
				trace("[NPC Manager] Cannot find pool for: ", getQualifiedClassName(unit));
			}
		}
		
		// depth sort lame method :p, do not use this on actual gameloop
		
		public function depthSort():void
		{
			var npc:CBaseTeelos = m_head;
			var buff:Array = [];
			
			while( npc != null ) 
			{
				if( npc.isActive() )
				{
					buff.push(npc);
					npc = npc.next;
				}
			}
			
			if( buff.length > 0 )
			{
				buff.sortOn("y");
				
				// detach
				for ( var i:int = 0; i < buff.length; i++ )
				{
					npc = CBaseTeelos(buff[i]);
					npc.detach();
					
				}
				
				// re-attach
				for ( i = 0; i < buff.length; i++ )
				{
					npc = CBaseTeelos(buff[i]);
					npc.attach();
				}
			}
		}
		
		public function getListOfUnit(lane:int, faction:String):Array
		{
			return m_lane[lane][faction];
		}
		
		public function getPlayerCount():int
		{
			return m_playerRef;
		}
		
		public function getEnemyCount():int
		{
			return m_enemyRef;
		}
		
		static public function getInstance(): NPCManager
	    {
			if( m_instance == null )
			{
            	m_instance = new NPCManager( new SingletonLock() );
            }
			return m_instance;
	    }
	}//end NPCManager
}

class SingletonLock{}