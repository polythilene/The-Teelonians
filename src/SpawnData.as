package  
{
	/**
	 * ...
	 * @author Wiwit
	 */
	public class SpawnData
	{
		static private var m_instance:SpawnData;
		
		private var m_data:XML;
		
		public function SpawnData(lock:SingletonLock) 
		{
			initialize();
		}
		
		private function initialize():void
		{
			m_data = new XML();
			m_data = 	<data>
							<level>
								<!-- Level 1-1 !-->
								<spawn research_point="1" lane_count="1" tick="6" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="1" count="6" />
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="1" max_rank="1" count="3" />
										<unit id="E01" min_rank="2" max_rank="2" count="1" />
									</wave>
								</spawn>

								<!-- Level 1-2 !-->
								<spawn research_point="1" lane_count="3" tick="5" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="10" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="3" max_rank="3" count="8" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="10" />
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="2" max_rank="3" count="10" />
									</wave>
								</spawn>

								<!-- Level 1-3 !-->
								<spawn research_point="1" lane_count="3" tick="5" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="5" />
										<unit id="E03" min_rank="1" max_rank="1" count="2" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="1" max_rank="2" count="4" />
										<unit id="E03" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="6" />
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="1" max_rank="2" count="12" />
										<unit id="E03" min_rank="3" max_rank="3" count="1" />
									</wave>
								</spawn>    

								<!-- Level 1-4 !-->
								<spawn research_point="1" lane_count="5" tick="4" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="2" count="8" />
										<unit id="E03" min_rank="1" max_rank="1" count="3" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="2" count="6" />
										<unit id="E03" min_rank="1" max_rank="1" count="3" />
									</wave>
									<wave type="normal">
										<unit id="E03" min_rank="1" max_rank="1" count="4" /> 
										<unit id="E01" min_rank="1" max_rank="2" count="8" />
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="2" max_rank="2" count="15" />
										<unit id="E03" min_rank="2" max_rank="2" count="6" />
									</wave>
								</spawn>    

								<!-- Level 1-5 !-->
								<spawn research_point="1" lane_count="5" tick="4" count="2" >
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="10" />
										<unit id="E02" min_rank="1" max_rank="1" count="1" />
										<unit id="E01" min_rank="1" max_rank="2" count="5" />
										<unit id="E03" min_rank="1" max_rank="1" count="2" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="3" count="8" />
										<unit id="E03" min_rank="1" max_rank="1" count="2" />
										<unit id="E02" min_rank="1" max_rank="1" count="3" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="3" />
										<unit id="E03" min_rank="1" max_rank="1" count="3" />
										<unit id="E01" min_rank="3" max_rank="3" count="3" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="3" count="8" />
										<unit id="E03" min_rank="1" max_rank="1" count="3" />
										<unit id="E02" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="3" count="5" />
										<unit id="E02" min_rank="1" max_rank="1" count="4" />
									</wave>
									<wave type="final">
										<unit id="E03" min_rank="1" max_rank="1" count="8" />
										<unit id="E02" min_rank="1" max_rank="1" count="8" />
										<unit id="E01" min_rank="2" max_rank="3" count="15" />  
									</wave>
								</spawn>    
							</level>
							<level>
								<!-- Level 2-1 !-->     
								<spawn research_point="1" lane_count="5" tick="6" count="2" >    
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="18" />
										<unit id="E02" min_rank="1" max_rank="2" count="1" />
									</wave>
									<wave type="big">
										<unit id="E03" min_rank="1" max_rank="3" count="2" />
										<unit id="E01" min_rank="1" max_rank="3" count="8" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="1" max_rank="2" count="1" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="2" max_rank="2" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="8" />
									</wave>
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="2" count="2" />
										<unit id="E01" min_rank="1" max_rank="2" count="2" />
									</wave>     
									<wave type="final">
										<unit id="E01" min_rank="3" max_rank="3" count="15" />
										<unit id="E03" min_rank="1" max_rank="1" count="12" />
										<unit id="E02" min_rank="1" max_rank="2" count="4" />
									</wave>
								</spawn>  

								<!-- Level 2-2 !-->   
								<spawn research_point="1" lane_count="5" tick="5" count="3" >  
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="3" count="8" />
										<unit id="E02" min_rank="1" max_rank="3" count="2" />
										<unit id="E01" min_rank="1" max_rank="3" count="8" />
										<unit id="E02" min_rank="1" max_rank="3" count="2" />
										<unit id="E03" min_rank="1" max_rank="3" count="4" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="1" max_rank="2" count="2" />
										<unit id="E07" min_rank="1" max_rank="2" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="3" count="8" />
										<unit id="E02" min_rank="1" max_rank="3" count="2" />
										<unit id="E01" min_rank="1" max_rank="3" count="8" />
										<unit id="E02" min_rank="1" max_rank="3" count="4" />
										<unit id="E03" min_rank="2" max_rank="3" count="4" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="3" max_rank="3" count="7" />
										<unit id="E02" min_rank="1" max_rank="2" count="6" />
										<unit id="E07" min_rank="3" max_rank="3" count="4" />
									</wave>
									<wave type="normal">                               
										<unit id="E01" min_rank="3" max_rank="3" count="16" /> 
										<unit id="E02" min_rank="3" max_rank="3" count="2" />
										<unit id="E07" min_rank="1" max_rank="2" count="4" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="1" max_rank="2" count="4" />
										<unit id="E07" min_rank="1" max_rank="2" count="6" />   
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="12" />
										<unit id="E07" min_rank="1" max_rank="2" count="4" />
										<unit id="E01" min_rank="1" max_rank="2" count="8" />
									</wave>  
									<wave type="final">
										<unit id="E07" min_rank="2" max_rank="3" count="15" /> 
									</wave>  
								</spawn>   
								<!-- Level 2-3 !-->
								<spawn research_point="1" lane_count="5" tick="5" count="3" >
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="2" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="12" />
										<unit id="E02" min_rank="2" max_rank="3" count="6" />
										<unit id="E07" min_rank="2" max_rank="3" count="14" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="2" max_rank="2" count="4" />
										<unit id="E01" min_rank="2" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="2" count="3" />
										<unit id="E07" min_rank="2" max_rank="2" count="6" />
										<unit id="E02" min_rank="2" max_rank="3" count="3" />
										<unit id="E07" min_rank="2" max_rank="3" count="6" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="2" max_rank="2" count="6" />
										<unit id="E01" min_rank="2" max_rank="3" count="12" />
										<unit id="E07" min_rank="2" max_rank="3" count="10" />
									</wave>     
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="2" count="3" />
										<unit id="E03" min_rank="1" max_rank="2" count="10" />
										<unit id="E02" min_rank="1" max_rank="2" count="6" />
										<unit id="E03" min_rank="1" max_rank="2" count="9" />
										<unit id="E01" min_rank="3" max_rank="3" count="6" />
										<unit id="E07" min_rank="1" max_rank="2" count="3" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="2" max_rank="2" count="6" />
										<unit id="E03" min_rank="2" max_rank="2" count="9" />
										<unit id="E01" min_rank="3" max_rank="3" count="15" />
									</wave>
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="2" count="3" />
										<unit id="E07" min_rank="1" max_rank="2" count="15" />
										<unit id="E03" min_rank="1" max_rank="2" count="6" />
									</wave>
									<wave type="final">   
										<unit id="E01" min_rank="2" max_rank="3" count="10" />
										<unit id="E02" min_rank="2" max_rank="3" count="9" />
										<unit id="E07" min_rank="2" max_rank="2" count="18" /> 
									</wave>
								</spawn>

								<!-- Level 2-4 !-->
								<spawn research_point="1" lane_count="5" tick="5" count="3" >
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="15" />
										<unit id="E03" min_rank="2" max_rank="3" count="8" /> 
										<unit id="E02" min_rank="2" max_rank="3" count="6" /> 
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="2" count="15" />
										<unit id="E05" min_rank="1" max_rank="2" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="3" />
										<unit id="E03" min_rank="2" max_rank="3" count="3" /> 
										<unit id="E02" min_rank="2" max_rank="3" count="6" /> 
										<unit id="E03" min_rank="2" max_rank="3" count="9" />
										<unit id="E01" min_rank="2" max_rank="3" count="6" />
										<unit id="E02" min_rank="2" max_rank="3" count="6" />
										<unit id="E03" min_rank="2" max_rank="3" count="3" />
										<unit id="E07" min_rank="2" max_rank="3" count="12" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="8" />
										<unit id="E01" min_rank="2" max_rank="2" count="6" />
										<unit id="E05" min_rank="1" max_rank="2" count="3" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="9" />
										<unit id="E03" min_rank="2" max_rank="3" count="3" /> 
										<unit id="E02" min_rank="2" max_rank="3" count="6" /> 
										<unit id="E03" min_rank="2" max_rank="3" count="3" />
										<unit id="E02" min_rank="2" max_rank="3" count="6" />
										<unit id="E03" min_rank="2" max_rank="3" count="3" />
										<unit id="E07" min_rank="2" max_rank="3" count="8" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="6" />
										<unit id="E07" min_rank="2" max_rank="2" count="9" />
										<unit id="E01" min_rank="2" max_rank="2" count="9" />
										<unit id="E05" min_rank="1" max_rank="2" count="4" />
									</wave>
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="3" count="6" />
										<unit id="E03" min_rank="1" max_rank="1" count="3" />
										<unit id="E07" min_rank="1" max_rank="3" count="6" />
										<unit id="E05" min_rank="1" max_rank="1" count="3" /> 
										<unit id="E01" min_rank="1" max_rank="3" count="3" />
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="2" max_rank="2" count="15" />
									</wave> 
									<wave type="normal">
										<unit id="E02" min_rank="1" max_rank="3" count="6" />   
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="3" max_rank="3" count="5" />
										<unit id="E07" min_rank="2" max_rank="2" count="8" />
										<unit id="E02" min_rank="2" max_rank="2" count="2" />                
										<unit id="E05" min_rank="1" max_rank="2" count="4" />
									</wave>
								</spawn>
								<!-- Level 2-5 !-->
								<spawn research_point="1" lane_count="5" tick="3" count="3" >
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="20" />
										<unit id="E03" min_rank="2" max_rank="2" count="15" />
										<unit id="E02" min_rank="2" max_rank="3" count="12" />
										<unit id="E07" min_rank="2" max_rank="3" count="10" />
										<unit id="E01" min_rank="2" max_rank="2" count="10" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="3" count="12" />
										<unit id="E03" min_rank="2" max_rank="2" count="10" />
										<unit id="E02" min_rank="2" max_rank="3" count="8" />
									</wave>
									<wave type="normal">
										<unit id="E03" min_rank="2" max_rank="2" count="10" />
										<unit id="E01" min_rank="2" max_rank="3" count="10" />
									</wave>
									<wave type="big">
										<unit id="E03" min_rank="2" max_rank="2" count="5" />
										<unit id="E02" min_rank="2" max_rank="3" count="5" />
										<unit id="E07" min_rank="2" max_rank="3" count="15" />
										<unit id="E05" min_rank="1" max_rank="3" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="15" />
										<unit id="E03" min_rank="2" max_rank="2" count="5" />   
									</wave>
									<wave type="final">
										<unit id="E01" min_rank="2" max_rank="3" count="2" />
										<unit id="E02" min_rank="2" max_rank="3" count="15" />
										<unit id="E05" min_rank="2" max_rank="3" count="4" />
										<unit id="E07" min_rank="2" max_rank="3" count="15" />
									</wave>
								</spawn>
							</level>
							<!-- level 3 -->
							<level>
								<!-- level 3-1 -->
								<spawn research_point="2" lane_count="5" tick="3" count="2" >
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="60" />
										<unit id="E02" min_rank="3" max_rank="3" count="2" />
										<unit id="E01" min_rank="1" max_rank="2" count="50" /> 
										<unit id="E07" min_rank="2" max_rank="3" count="20" />
										<unit id="E02" min_rank="3" max_rank="3" count="6" />
										<unit id="E01" min_rank="1" max_rank="2" count="8" />
									</wave>
									<wave type="big">     
										<unit id="E02" min_rank="2" max_rank="2" count="4" />
										<unit id="E03" min_rank="2" max_rank="2" count="16" />   
									</wave>
									<wave type="normal">   
										<unit id="E01" min_rank="1" max_rank="2" count="20" />
										<unit id="E07" min_rank="2" max_rank="3" count="18" />
										<unit id="E04" min_rank="1" max_rank="1" count="2" />
										<unit id="E02" min_rank="3" max_rank="3" count="4" />  
									</wave>
									<wave type="big">
										<unit id="E04" min_rank="1" max_rank="1" count="6" />
									</wave>
									<wave type="normal">
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="2" max_rank="2" count="8" />
										<unit id="E03" min_rank="2" max_rank="2" count="10" />
										<unit id="E05" min_rank="1" max_rank="1" count="3" />
										<unit id="E01" min_rank="1" max_rank="2" count="20" />
									</wave>
									<wave type="final">
										<unit id="E04" min_rank="1" max_rank="1" count="4" />
										<unit id="E03" min_rank="2" max_rank="2" count="9" />
										<unit id="E05" min_rank="1" max_rank="1" count="3" />
										<unit id="E07" min_rank="1" max_rank="1" count="15" />
									</wave>
								</spawn>  
								<!-- level 3-2 -->
								<spawn research_point="2" lane_count="5" tick="5" count="3" >
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />  
										<unit id="E02" min_rank="2" max_rank="3" count="10" />
										<unit id="E03" min_rank="2" max_rank="3" count="25" />
										<unit id="E05" min_rank="1" max_rank="3" count="2" />
										<unit id="E07" min_rank="2" max_rank="3" count="10" />
										<unit id="E09" min_rank="1" max_rank="2" count="3" />
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="3" max_rank="3" count="15" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E05" min_rank="2" max_rank="2" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E03" min_rank="2" max_rank="2" count="12" />
										<unit id="E05" min_rank="1" max_rank="1" count="4" />
										<unit id="E02" min_rank="3" max_rank="3" count="10" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E02" min_rank="2" max_rank="3" count="10" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E09" min_rank="1" max_rank="2" count="3" />
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="3" max_rank="3" count="20" />
										<unit id="E02" min_rank="3" max_rank="3" count="6" />
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E05" min_rank="1" max_rank="1" count="6" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
									</wave>
									<wave type="big"> 
										<unit id="E07" min_rank="1" max_rank="2" count="20" />
										<unit id="E09" min_rank="1" max_rank="2" count="6" />
										<unit id="E05" min_rank="1" max_rank="1" count="4" /> 
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
									</wave>
									<wave type="final"> 
										<unit id="E07" min_rank="1" max_rank="2" count="5" />
										<unit id="E09" min_rank="1" max_rank="2" count="10" />
										<unit id="E05" min_rank="1" max_rank="1" count="4" /> 
									</wave>
								</spawn>
								<!-- level 3-3 -->
								<spawn research_point="2" lane_count="5" tick="4" count="3" >
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="50" /> 
										<unit id="E02" min_rank="3" max_rank="3" count="10" /> 
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E02" min_rank="2" max_rank="2" count="10" />
										<unit id="E07" min_rank="3" max_rank="3" count="15" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" /> 
										<unit id="E02" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="2" max_rank="2" count="15" />
										<unit id="E02" min_rank="2" max_rank="2" count="5" />
										<unit id="E09" min_rank="2" max_rank="2" count="6" />
										<unit id="E04" min_rank="2" max_rank="2" count="2" />
										<unit id="E01" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="1" count="1" />
										<unit id="E02" min_rank="2" max_rank="2" count="15" />
										<unit id="E04" min_rank="2" max_rank="2" count="1" />
										<unit id="E02" min_rank="2" max_rank="2" count="15" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E01" min_rank="3" max_rank="3" count="60" />
									</wave>
									<wave type="big">
										<unit id="E04" min_rank="2" max_rank="2" count="4" />
										<unit id="E03" min_rank="2" max_rank="2" count="8" />
										<unit id="E07" min_rank="2" max_rank="2" count="5" />
										<unit id="E09" min_rank="2" max_rank="2" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="1" count="2" />
										<unit id="E03" min_rank="2" max_rank="2" count="9" />
										<unit id="E04" min_rank="2" max_rank="2" count="11" />
										<unit id="E03" min_rank="2" max_rank="2" count="5" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E01" min_rank="3" max_rank="3" count="40" />
									</wave>
									<wave type="final">
										<unit id="E04" min_rank="2" max_rank="2" count="2" />
										<unit id="E02" min_rank="2" max_rank="2" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="6" />
										<unit id="E09" min_rank="2" max_rank="2" count="8" />
									</wave>
								</spawn>
								<!-- level 3-4 -->
								<spawn research_point="2" lane_count="5" tick="4" count="3" >
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E03" min_rank="3" max_rank="3" count="8" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E03" min_rank="3" max_rank="3" count="8" />
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="3" max_rank="3" count="16" />
										<unit id="E03" min_rank="3" max_rank="3" count="16" />
									</wave>
									<wave type="normal">
										<unit id="E07" min_rank="3" max_rank="3" count="16" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E02" min_rank="1" max_rank="3" count="5" />
										<unit id="E07" min_rank="3" max_rank="3" count="16" /> 
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E02" min_rank="1" max_rank="3" count="9" />
										<unit id="E01" min_rank="3" max_rank="3" count="12" />
										<unit id="E07" min_rank="3" max_rank="3" count="15" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="5" />
										<unit id="E07" min_rank="2" max_rank="3" count="20" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="1" count="3" />
										<unit id="E02" min_rank="3" max_rank="3" count="15" />
										<unit id="E04" min_rank="1" max_rank="1" count="2" />
										<unit id="E07" min_rank="3" max_rank="3" count="8" />
										<unit id="E02" min_rank="2" max_rank="3" count="15" />    
										<unit id="E07" min_rank="2" max_rank="3" count="8" />    
										<unit id="E02" min_rank="3" max_rank="3" count="16" />       
										<unit id="E04" min_rank="1" max_rank="1" count="3" />
										<unit id="E08" min_rank="1" max_rank="1" count="3" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="12" /> 
										<unit id="E07" min_rank="3" max_rank="3" count="10" /> 
										<unit id="E04" min_rank="1" max_rank="1" count="3" />        
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="1" count="2" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E03" min_rank="3" max_rank="3" count="15" />
										<unit id="E01" min_rank="2" max_rank="3" count="15" />    
										<unit id="E07" min_rank="2" max_rank="3" count="15" />    
										<unit id="E02" min_rank="2" max_rank="3" count="25" />    
										<unit id="E11" min_rank="1" max_rank="2" count="4" />    
										<unit id="E07" min_rank="1" max_rank="1" count="21" />
										<unit id="E04" min_rank="1" max_rank="1" count="3" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E08" min_rank="1" max_rank="1" count="3" /> 
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="10" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="2" max_rank="3" count="3" />
										<unit id="E01" min_rank="2" max_rank="3" count="20" />
										<unit id="E04" min_rank="2" max_rank="3" count="5" />  
										<unit id="E01" min_rank="2" max_rank="3" count="20" />      
										<unit id="E02" min_rank="2" max_rank="3" count="15" />
										<unit id="E04" min_rank="2" max_rank="3" count="3" />      
										<unit id="E08" min_rank="2" max_rank="3" count="3" />      
									</wave>
									<wave type="final"> 
										<unit id="E11" min_rank="1" max_rank="1" count="3" />    
										<unit id="E02" min_rank="2" max_rank="3" count="10" />     
										<unit id="E07" min_rank="2" max_rank="3" count="15" />     
									</wave>

								</spawn>
								<!-- level 3-5 -->
								<!-- Infantry Wave     -->
								<spawn research_point="2" lane_count="5" tick="5" count="5" >
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="30" />
										<unit id="E09" min_rank="3" max_rank="3" count="4" />
										<unit id="E07" min_rank="3" max_rank="3" count="16" />
										<unit id="E09" min_rank="2" max_rank="3" count="4" />
										<unit id="E07" min_rank="3" max_rank="3" count="16" />                
										<unit id="E09" min_rank="3" max_rank="3" count="4" /> 
										<unit id="E10" min_rank="1" max_rank="3" count="1" />               
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="3" max_rank="3" count="12" />
										<unit id="E09" min_rank="3" max_rank="3" count="6" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="2" max_rank="2" count="3" />
										<unit id="E01" min_rank="2" max_rank="3" count="60" />  
										<unit id="E01" min_rank="2" max_rank="3" count="30" />  
										<unit id="E04" min_rank="2" max_rank="3" count="3" />
										<unit id="E05" min_rank="2" max_rank="3" count="3" />    
									</wave>
									<wave type="big">
										<unit id="E09" min_rank="3" max_rank="3" count="6" />
										<unit id="E04" min_rank="3" max_rank="3" count="4" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="2" max_rank="3" count="30" />
										<unit id="E07" min_rank="2" max_rank="3" count="7" />
										<unit id="E05" min_rank="2" max_rank="3" count="2" />
										<unit id="E01" min_rank="2" max_rank="3" count="20" />
									</wave> 
									<wave type="final">
										<unit id="E09" min_rank="3" max_rank="3" count="10" />
										<unit id="E07" min_rank="2" max_rank="2" count="10" />                
									</wave>
								</spawn>
							</level>
							<!-- level 4 -->
							<level>
								<!-- level 4-1 -->
								<spawn research_point="2" lane_count="5" tick="2" count="1" > 
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="3" count="30" />
										<unit id="E05" min_rank="1" max_rank="1" count="2" />
										<unit id="E03" min_rank="1" max_rank="3" count="10" />
										<unit id="E02" min_rank="2" max_rank="3" count="3" />
										<unit id="E01" min_rank="2" max_rank="3" count="30" />
										<unit id="E07" min_rank="1" max_rank="1" count="5" />
										<unit id="E02" min_rank="1" max_rank="1" count="5" />
										<unit id="E05" min_rank="1" max_rank="1" count="2" />
									</wave>
									<wave type="big">
										<unit id="E07" min_rank="1" max_rank="1" count="4" />
										<unit id="E01" min_rank="1" max_rank="3" count="20" />
										<unit id="E04" min_rank="1" max_rank="2" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="2" max_rank="2" count="2" />
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
										<unit id="E02" min_rank="1" max_rank="1" count="5" />
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
										<unit id="E01" min_rank="1" max_rank="2" count="40" />
									</wave>
									<wave type="big">
										<unit id="E06" min_rank="1" max_rank="1" count="1" />
										<unit id="E09" min_rank="2" max_rank="2" count="2" />
										<unit id="E02" min_rank="2" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="1" count="3" />      
										<unit id="E04" min_rank="2" max_rank="3" count="2" />
										<unit id="E02" min_rank="2" max_rank="3" count="10" />
										<unit id="E07" min_rank="2" max_rank="2" count="5" />
										<unit id="E09" min_rank="2" max_rank="2" count="2" />
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
										<unit id="E01" min_rank="2" max_rank="3" count="20" />
									</wave>
									<wave type="final">
										<unit id="E06" min_rank="1" max_rank="1" count="1" />
										<unit id="E09" min_rank="2" max_rank="2" count="2" />
										<unit id="E01" min_rank="2" max_rank="3" count="20" />
										<unit id="E11" min_rank="1" max_rank="1" count="3" />
										<unit id="E05" min_rank="3" max_rank="3" count="4" /> 
									</wave>
								</spawn>
								<!-- level 4-2 -->
								<spawn research_point="2" lane_count="5" tick="2" count="1" >
									<!-- Cavalry Wave     -->
									<wave type="normal">  
										<unit id="E05" min_rank="2" max_rank="3" count="6" />
										<unit id="E01" min_rank="2" max_rank="3" count="30" />
										<unit id="E05" min_rank="2" max_rank="3" count="6" />
										<unit id="E01" min_rank="2" max_rank="3" count="30" />
										<unit id="E07" min_rank="1" max_rank="1" count="15" />
										<unit id="E02" min_rank="2" max_rank="2" count="5" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E09" min_rank="2" max_rank="2" count="3" />
										<unit id="E07" min_rank="3" max_rank="3" count="6" />
										<unit id="E05" min_rank="3" max_rank="3" count="4" />
									</wave>
									<wave type="big">
										<unit id="E05" min_rank="3" max_rank="3" count="6" />
										<unit id="E06" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="normal">
										<unit id="E11" min_rank="1" max_rank="2" count="2" />
										<unit id="E07" min_rank="1" max_rank="2" count="4" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E13" min_rank="2" max_rank="2" count="1" />  
										<unit id="E05" min_rank="2" max_rank="3" count="4" />
										<unit id="E01" min_rank="1" max_rank="1" count="20" />
										<unit id="E05" min_rank="1" max_rank="3" count="12" />
										<unit id="E02" min_rank="2" max_rank="2" count="4" />
										<unit id="E06" min_rank="2" max_rank="2" count="1" />
										<unit id="E01" min_rank="2" max_rank="2" count="16" />
										<unit id="E04" min_rank="2" max_rank="2" count="4" />

									</wave>
									<wave type="big">
										<unit id="E11" min_rank="1" max_rank="2" count="5" />
										<unit id="E01" min_rank="1" max_rank="2" count="20" />
										<unit id="E04" min_rank="1" max_rank="2" count="6" />
										<unit id="E09" min_rank="1" max_rank="2" count="4" />
										<unit id="E06" min_rank="1" max_rank="2" count="1" />
									</wave>
									<wave type="normal">
										<unit id="E03" min_rank="2" max_rank="2" count="30" />
										<unit id="E04" min_rank="2" max_rank="2" count="10" />
										<unit id="E11" min_rank="1" max_rank="1" count="5" />
										<unit id="E02" min_rank="3" max_rank="3" count="15" />
									</wave>
									<wave type="final">
										<unit id="E11" min_rank="1" max_rank="1" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="15" />
										<unit id="E09" min_rank="3" max_rank="3" count="3" />
										<unit id="E06" min_rank="1" max_rank="1" count="1" />
										<unit id="E13" min_rank="2" max_rank="2" count="2" />
									</wave>
								</spawn>
								<!-- level 4-3 -->
								<spawn research_point="3" lane_count="5" tick="4" count="4" >
									<!-- Siege Wave     --> 
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="2" count="30" />
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="1" max_rank="2" count="30" />
										<unit id="E07" min_rank="2" max_rank="2" count="3" />
										<unit id="E09" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="normal">
										<unit id="E10" min_rank="1" max_rank="1" count="2" />
										<unit id="E01" min_rank="1" max_rank="3" count="40" />
										<unit id="E07" min_rank="1" max_rank="1" count="12" />
										<unit id="E01" min_rank="3" max_rank="3" count="16" />
										<unit id="E05" min_rank="3" max_rank="3" count="2" />
										<unit id="E08" min_rank="3" max_rank="3" count="2" />
										<unit id="E03" min_rank="3" max_rank="3" count="12" />
										<unit id="E09" min_rank="3" max_rank="3" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="8" />
									</wave>
									<wave type="big">
										<unit id="E08" min_rank="1" max_rank="3" count="3" />
										<unit id="E04" min_rank="2" max_rank="3" count="1" />
										<unit id="E03" min_rank="2" max_rank="3" count="8" />
										<unit id="E09" min_rank="2" max_rank="3" count="2" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />
										<unit id="E02" min_rank="3" max_rank="3" count="12" />
										<unit id="E06" min_rank="3" max_rank="3" count="1" />
										<unit id="E07" min_rank="2" max_rank="2" count="15" />
										<unit id="E03" min_rank="3" max_rank="3" count="12" />
										<unit id="E10" min_rank="1" max_rank="3" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="12" />
										<unit id="E10" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="big">
										<unit id="E09" min_rank="2" max_rank="2" count="16" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="1" max_rank="1" count="60" />
										<unit id="E03" min_rank="1" max_rank="1" count="10" />
										<unit id="E01" min_rank="1" max_rank="1" count="30" />
									</wave>
									<wave type="final">
										<unit id="E08" min_rank="1" max_rank="1" count="5" />
										<unit id="E09" min_rank="2" max_rank="2" count="3" />
										<unit id="E10" min_rank="3" max_rank="3" count="2" />
										<unit id="E11" min_rank="2" max_rank="2" count="1" />
									</wave>
								</spawn>
								<!-- level 4-4 -->
								<spawn research_point="3" lane_count="5" tick="1" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />          
										<unit id="E03" min_rank="3" max_rank="3" count="10" />          
										<unit id="E01" min_rank="3" max_rank="3" count="30" />          
										<unit id="E03" min_rank="3" max_rank="3" count="10" />          
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="3" max_rank="3" count="25" />          
										<unit id="E03" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E07" min_rank="3" max_rank="3" count="8" />
										<unit id="E02" min_rank="3" max_rank="3" count="6" />
										<unit id="E07" min_rank="3" max_rank="3" count="8" />
										<unit id="E10" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
										<unit id="E06" min_rank="3" max_rank="3" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="40" />
									</wave>
									<wave type="big">
										<unit id="E05" min_rank="2" max_rank="2" count="5" />
										<unit id="E06" min_rank="3" max_rank="3" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E08" min_rank="2" max_rank="2" count="3" />
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E01" min_rank="3" max_rank="3" count="15" />
										<unit id="E08" min_rank="2" max_rank="2" count="3" />
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
									</wave>
									<wave type="big">
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="4" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="25" />
										<unit id="E10" min_rank="2" max_rank="2" count="3" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" /> 
										<unit id="E03" min_rank="3" max_rank="3" count="5" /> 
									</wave>
									<wave type="final">
										<unit id="E06" min_rank="2" max_rank="2" count="4" />           
									</wave>
								</spawn>
								<!-- level 4-5 -->
								<spawn research_point="3" lane_count="5" tick="1" count="1" >
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="30" />          
										<unit id="E03" min_rank="3" max_rank="3" count="10" />          
										<unit id="E01" min_rank="3" max_rank="3" count="30" />          
										<unit id="E03" min_rank="3" max_rank="3" count="10" />          
									</wave>
									<wave type="big">
										<unit id="E01" min_rank="3" max_rank="3" count="25" />          
										<unit id="E03" min_rank="3" max_rank="3" count="15" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E07" min_rank="3" max_rank="3" count="10" />
										<unit id="E10" min_rank="1" max_rank="1" count="1" />
									</wave>
									<wave type="big">
										<unit id="E02" min_rank="3" max_rank="3" count="8" />
										<unit id="E07" min_rank="3" max_rank="3" count="15" />
									</wave>
									<wave type="normal">
										<unit id="E05" min_rank="2" max_rank="2" count="3" />
										<unit id="E06" min_rank="3" max_rank="3" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="40" />
									</wave>
									<wave type="big">
										<unit id="E05" min_rank="2" max_rank="2" count="5" />
										<unit id="E06" min_rank="3" max_rank="3" count="1" />
										<unit id="E01" min_rank="3" max_rank="3" count="10" />
									</wave>
									<wave type="normal">
										<unit id="E08" min_rank="2" max_rank="2" count="3" />
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E01" min_rank="3" max_rank="3" count="15" />
										<unit id="E08" min_rank="2" max_rank="2" count="3" />
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E01" min_rank="3" max_rank="3" count="20" />
									</wave>
									<wave type="big">
										<unit id="E09" min_rank="2" max_rank="2" count="4" />
										<unit id="E07" min_rank="2" max_rank="2" count="8" />
									</wave>
									<wave type="normal">
										<unit id="E01" min_rank="3" max_rank="3" count="25" />
										<unit id="E10" min_rank="2" max_rank="2" count="3" />
										<unit id="E01" min_rank="3" max_rank="3" count="30" /> 
										<unit id="E03" min_rank="3" max_rank="3" count="5" /> 
									</wave>
									<wave type="final">
										<unit id="E06" min_rank="2" max_rank="2" count="6" />           
									</wave>
								</spawn>
							</level>
							<level>
								<!-- level 5 -->
								<spawn research_point="3" lane_count="5" tick="1" count="1" >
									<wave type="bossfight">
										<unit id="E12" min_rank="2" max_rank="2" count="1" />              
									</wave>  
								</spawn>
							</level>
						</data>
		}
		
		public function getData():XML
		{
			return m_data;
		}
		
		static public function getInstance(): SpawnData
		{
			if ( m_instance == null )
			{
				m_instance = new SpawnData( new SingletonLock() );
			}
			return m_instance;
		}
		
	}

}

class SingletonLock{}